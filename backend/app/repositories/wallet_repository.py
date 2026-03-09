import uuid
from decimal import Decimal
from sqlalchemy import select
from sqlalchemy.ext.asyncio import AsyncSession
from app.models.wallet import Wallet
from app.repositories.base_repository import BaseRepository


class WalletRepository(BaseRepository[Wallet]):
    def __init__(self, db: AsyncSession):
        super().__init__(Wallet, db)

    async def get_by_user_id(self, user_id: uuid.UUID) -> Wallet | None:
        result = await self.db.execute(
            select(Wallet).where(Wallet.user_id == user_id)
        )
        return result.scalar_one_or_none()

    async def credit(self, wallet: Wallet, amount: Decimal) -> Wallet:
        """Add funds. Always use this — never mutate balance directly."""
        wallet.balance += amount
        await self.db.flush()
        return wallet

    async def debit(self, wallet: Wallet, amount: Decimal) -> Wallet:
        """Deduct funds. Caller must verify sufficient balance first."""
        wallet.balance -= amount
        await self.db.flush()
        return wallet
