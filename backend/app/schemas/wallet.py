import uuid
from decimal import Decimal
from datetime import datetime
from pydantic import BaseModel, field_validator


class WalletResponse(BaseModel):
    id: uuid.UUID
    user_id: uuid.UUID
    balance: Decimal
    currency: str
    is_frozen: bool
    updated_at: datetime

    model_config = {"from_attributes": True}


class DepositRequest(BaseModel):
    amount: Decimal
    description: str | None = None

    @field_validator("amount")
    @classmethod
    def amount_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("Amount must be greater than zero")
        return v


class TransferRequest(BaseModel):
    receiver_email: str
    amount: Decimal
    description: str | None = None

    @field_validator("amount")
    @classmethod
    def amount_positive(cls, v: Decimal) -> Decimal:
        if v <= 0:
            raise ValueError("Amount must be greater than zero")
        return v
