import uuid
from decimal import Decimal
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.exceptions import (
    NotFoundError,
    InsufficientFundsError,
    WalletFrozenError,
    BadRequestError,
)
from app.models.wallet import Wallet
from app.repositories.wallet_repository import WalletRepository
from app.repositories.user_repository import UserRepository
from app.repositories.transaction_repository import TransactionRepository
from app.schemas.wallet import DepositRequest, TransferRequest


TRANSFER_FEE_PERCENT = Decimal("0.005")  # 0.5%


class WalletService:
    def __init__(self, db: AsyncSession):
        self.db = db
        self.wallet_repo = WalletRepository(db)
        self.user_repo = UserRepository(db)
        self.tx_repo = TransactionRepository(db)

    async def get_wallet(self, user_id: uuid.UUID) -> Wallet:
        wallet = await self.wallet_repo.get_by_user_id(user_id)
        if not wallet:
            raise NotFoundError("Wallet")
        return wallet

    async def deposit(
        self, user_id: uuid.UUID, payload: DepositRequest
    ) -> Wallet:
        wallet = await self.get_wallet(user_id)
        if wallet.is_frozen:
            raise WalletFrozenError()

        await self.wallet_repo.credit(wallet, payload.amount)
        await self.tx_repo.create(
            sender_id=None,
            receiver_id=user_id,
            wallet_id=wallet.id,
            amount=payload.amount,
            fee=Decimal("0.00"),
            type="deposit",
            status="completed",
            reference=self._generate_reference(),
            description=payload.description or "Deposit",
        )
        return wallet

    async def transfer(
        self, sender_id: uuid.UUID, payload: TransferRequest
    ) -> dict:
        sender_wallet = await self.get_wallet(sender_id)
        if sender_wallet.is_frozen:
            raise WalletFrozenError()

        receiver = await self.user_repo.get_by_email(payload.receiver_email.lower())
        if not receiver:
            raise NotFoundError("Receiver")
        if receiver.id == sender_id:
            raise BadRequestError("Cannot transfer to yourself")

        receiver_wallet = await self.wallet_repo.get_by_user_id(receiver.id)
        if not receiver_wallet:
            raise NotFoundError("Receiver wallet")
        if receiver_wallet.is_frozen:
            raise BadRequestError("Receiver's wallet is frozen")

        fee = (payload.amount * TRANSFER_FEE_PERCENT).quantize(Decimal("0.01"))
        total_debit = payload.amount + fee

        if sender_wallet.balance < total_debit:
            raise InsufficientFundsError()

        await self.wallet_repo.debit(sender_wallet, total_debit)
        await self.wallet_repo.credit(receiver_wallet, payload.amount)

        tx = await self.tx_repo.create(
            sender_id=sender_id,
            receiver_id=receiver.id,
            wallet_id=sender_wallet.id,
            amount=payload.amount,
            fee=fee,
            type="transfer",
            status="completed",
            reference=self._generate_reference(),
            description=payload.description or f"Transfer to {receiver.email}",
        )
        return {"transaction": tx, "sender_wallet": sender_wallet}

    @staticmethod
    def _generate_reference() -> str:
        import uuid as _uuid
        return f"TXN-{str(_uuid.uuid4()).upper().replace('-', '')[:16]}"
