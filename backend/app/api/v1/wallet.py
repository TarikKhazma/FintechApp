from fastapi import APIRouter, Depends
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.core.dependencies import get_current_user
from app.models.user import User
from app.schemas.wallet import WalletResponse, DepositRequest, TransferRequest
from app.schemas.transaction import TransactionResponse
from app.schemas.common import ApiResponse
from app.services.wallet_service import WalletService

router = APIRouter(prefix="/wallet", tags=["Wallet"])


@router.get(
    "",
    response_model=ApiResponse[WalletResponse],
    summary="Get the current user's wallet",
)
async def get_wallet(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    service = WalletService(db)
    wallet = await service.get_wallet(current_user.id)
    return ApiResponse.ok(WalletResponse.model_validate(wallet))


@router.post(
    "/deposit",
    response_model=ApiResponse[WalletResponse],
    summary="Deposit funds into wallet",
)
async def deposit(
    payload: DepositRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    service = WalletService(db)
    wallet = await service.deposit(current_user.id, payload)
    return ApiResponse.ok(WalletResponse.model_validate(wallet), "Deposit successful")


@router.post(
    "/transfer",
    response_model=ApiResponse[TransactionResponse],
    summary="Transfer funds to another user",
)
async def transfer(
    payload: TransferRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    service = WalletService(db)
    result = await service.transfer(current_user.id, payload)
    tx = result["transaction"]
    return ApiResponse.ok(
        TransactionResponse.model_validate(tx),
        "Transfer completed successfully",
    )
