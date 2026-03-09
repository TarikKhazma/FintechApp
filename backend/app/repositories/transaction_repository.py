import uuid
from sqlalchemy import select, or_
from sqlalchemy.ext.asyncio import AsyncSession
from app.models.transaction import Transaction
from app.repositories.base_repository import BaseRepository


class TransactionRepository(BaseRepository[Transaction]):
    def __init__(self, db: AsyncSession):
        super().__init__(Transaction, db)

    async def get_user_transactions(
        self,
        user_id: uuid.UUID,
        offset: int = 0,
        limit: int = 20,
        type_filter: str | None = None,
        status_filter: str | None = None,
    ) -> tuple[list[Transaction], int]:
        """Return paginated transactions where user is sender or receiver."""
        query = select(Transaction).where(
            or_(
                Transaction.sender_id == user_id,
                Transaction.receiver_id == user_id,
            )
        )
        if type_filter:
            query = query.where(Transaction.type == type_filter)
        if status_filter:
            query = query.where(Transaction.status == status_filter)

        query = query.order_by(Transaction.created_at.desc())

        from sqlalchemy import func, select as sa_select
        count_q = sa_select(func.count()).select_from(query.subquery())
        total = (await self.db.execute(count_q)).scalar_one()

        paged = (await self.db.execute(query.offset(offset).limit(limit))).scalars().all()
        return list(paged), total

    async def get_by_reference(self, reference: str) -> Transaction | None:
        result = await self.db.execute(
            select(Transaction).where(Transaction.reference == reference)
        )
        return result.scalar_one_or_none()
