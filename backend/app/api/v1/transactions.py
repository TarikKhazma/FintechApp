import uuid
from fastapi import APIRouter, Depends, Query
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.core.dependencies import get_current_user
from app.models.user import User
from app.schemas.transaction import TransactionResponse, TransactionFilters
from app.schemas.common import ApiResponse, PaginatedResponse
from app.services.transaction_service import TransactionService

router = APIRouter(prefix="/transactions", tags=["Transactions"])


@router.get(
    "",
    response_model=PaginatedResponse[TransactionResponse],
    summary="List paginated transactions for the current user",
)
async def list_transactions(
    type: str | None = Query(None, description="Filter by type: transfer|deposit|withdrawal|payment"),
    status: str | None = Query(None, description="Filter by status: pending|completed|failed|reversed"),
    page: int = Query(1, ge=1),
    page_size: int = Query(20, ge=1, le=100),
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    service = TransactionService(db)
    filters = TransactionFilters(
        type=type, status=status, page=page, page_size=page_size  # type: ignore[arg-type]
    )
    items, meta = await service.list_for_user(current_user.id, filters)
    return PaginatedResponse(
        data=[TransactionResponse.model_validate(t) for t in items],
        meta=meta,
    )


@router.get(
    "/{transaction_id}",
    response_model=ApiResponse[TransactionResponse],
    summary="Get a single transaction by ID",
)
async def get_transaction(
    transaction_id: uuid.UUID,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    service = TransactionService(db)
    tx = await service.get_by_id(transaction_id, current_user.id)
    return ApiResponse.ok(TransactionResponse.model_validate(tx))
