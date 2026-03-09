import uuid
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.exceptions import NotFoundError, ForbiddenError
from app.models.transaction import Transaction
from app.repositories.transaction_repository import TransactionRepository
from app.schemas.transaction import TransactionFilters
from app.schemas.common import PaginationMeta


class TransactionService:
    def __init__(self, db: AsyncSession):
        self.repo = TransactionRepository(db)

    async def list_for_user(
        self,
        user_id: uuid.UUID,
        filters: TransactionFilters,
    ) -> tuple[list[Transaction], PaginationMeta]:
        offset = (filters.page - 1) * filters.page_size
        items, total = await self.repo.get_user_transactions(
            user_id=user_id,
            offset=offset,
            limit=filters.page_size,
            type_filter=filters.type,
            status_filter=filters.status,
        )
        total_pages = -(-total // filters.page_size)  # ceiling division
        meta = PaginationMeta(
            total=total,
            page=filters.page,
            page_size=filters.page_size,
            total_pages=total_pages,
        )
        return items, meta

    async def get_by_id(
        self, transaction_id: uuid.UUID, user_id: uuid.UUID
    ) -> Transaction:
        tx = await self.repo.get_by_id(transaction_id)
        if not tx:
            raise NotFoundError("Transaction")
        # Users can only see their own transactions
        if tx.sender_id != user_id and tx.receiver_id != user_id:
            raise ForbiddenError()
        return tx
