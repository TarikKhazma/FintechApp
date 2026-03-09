import uuid
from decimal import Decimal
from datetime import datetime
from typing import Literal
from pydantic import BaseModel

TransactionType = Literal["transfer", "deposit", "withdrawal", "payment"]
TransactionStatus = Literal["pending", "completed", "failed", "reversed"]


class TransactionResponse(BaseModel):
    id: uuid.UUID
    sender_id: uuid.UUID | None
    receiver_id: uuid.UUID | None
    amount: Decimal
    fee: Decimal
    type: str
    status: str
    reference: str
    description: str | None
    created_at: datetime
    completed_at: datetime | None

    model_config = {"from_attributes": True}


class TransactionFilters(BaseModel):
    type: TransactionType | None = None
    status: TransactionStatus | None = None
    page: int = 1
    page_size: int = 20
