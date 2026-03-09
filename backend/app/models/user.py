import uuid
from sqlalchemy import String, Boolean
from sqlalchemy.orm import Mapped, mapped_column, relationship
from sqlalchemy.dialects.postgresql import UUID
from app.db.base import Base, TimestampMixin


class User(Base, TimestampMixin):
    __tablename__ = "users"

    id: Mapped[uuid.UUID] = mapped_column(
        UUID(as_uuid=True), primary_key=True, default=uuid.uuid4
    )
    email: Mapped[str] = mapped_column(
        String(255), unique=True, nullable=False, index=True
    )
    full_name: Mapped[str | None] = mapped_column(String(255), nullable=True)
    phone: Mapped[str | None] = mapped_column(
        String(20), unique=True, nullable=True, index=True
    )
    password_hash: Mapped[str] = mapped_column(String, nullable=False)
    is_verified: Mapped[bool] = mapped_column(Boolean, default=False)
    is_active: Mapped[bool] = mapped_column(Boolean, default=True)
    is_admin: Mapped[bool] = mapped_column(Boolean, default=False)
    kyc_status: Mapped[str] = mapped_column(
        String(20), default="pending"  # pending | verified | rejected
    )

    # Relationships
    wallet: Mapped["Wallet"] = relationship(  # noqa: F821
        "Wallet", back_populates="user", uselist=False, lazy="selectin"
    )
    sent_transactions: Mapped[list["Transaction"]] = relationship(  # noqa: F821
        "Transaction", foreign_keys="Transaction.sender_id", back_populates="sender"
    )
    received_transactions: Mapped[list["Transaction"]] = relationship(  # noqa: F821
        "Transaction", foreign_keys="Transaction.receiver_id", back_populates="receiver"
    )
    refresh_tokens: Mapped[list["RefreshToken"]] = relationship(  # noqa: F821
        "RefreshToken", back_populates="user", cascade="all, delete-orphan"
    )

    def __repr__(self) -> str:
        return f"<User id={self.id} email={self.email}>"
