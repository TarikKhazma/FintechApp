from datetime import datetime, timedelta, timezone
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.security import (
    hash_password,
    verify_password,
    create_access_token,
    create_refresh_token,
    decode_token,
)
from app.core.exceptions import (
    ConflictError,
    InvalidCredentialsError,
    UnauthorizedError,
)
from app.repositories.user_repository import UserRepository
from app.repositories.wallet_repository import WalletRepository
from app.repositories.refresh_token_repository import RefreshTokenRepository
from app.schemas.auth import SignUpRequest, SignInRequest, AuthTokenResponse
from app.config import settings


class AuthService:
    def __init__(self, db: AsyncSession):
        self.db = db
        self.user_repo = UserRepository(db)
        self.wallet_repo = WalletRepository(db)
        self.token_repo = RefreshTokenRepository(db)

    async def signup(self, payload: SignUpRequest) -> AuthTokenResponse:
        if await self.user_repo.email_exists(payload.email):
            raise ConflictError("An account with this email already exists")

        user = await self.user_repo.create(
            email=payload.email.lower(),
            password_hash=hash_password(payload.password),
        )

        # Auto-create wallet for new users
        await self.wallet_repo.create(user_id=user.id)

        access_token = create_access_token(str(user.id))
        refresh_token = await self._issue_refresh_token(str(user.id))

        return AuthTokenResponse(
            token=access_token,
            email=user.email,
            refresh_token=refresh_token,
        )

    async def signin(self, payload: SignInRequest) -> AuthTokenResponse:
        user = await self.user_repo.get_by_email(payload.email.lower())
        if not user or not verify_password(payload.password, user.password_hash):
            raise InvalidCredentialsError()

        access_token = create_access_token(str(user.id))
        refresh_token = await self._issue_refresh_token(str(user.id))

        return AuthTokenResponse(
            token=access_token,
            email=user.email,
            refresh_token=refresh_token,
        )

    async def refresh(self, raw_token: str) -> AuthTokenResponse:
        record = await self.token_repo.get_valid_token(raw_token)
        if not record:
            raise UnauthorizedError("Invalid or expired refresh token")

        # Rotate: revoke old, issue new
        record.revoked = True
        user = await self.user_repo.get_by_id(record.user_id)
        if not user:
            raise UnauthorizedError("User not found")

        access_token = create_access_token(str(user.id))
        new_refresh = await self._issue_refresh_token(str(user.id))

        return AuthTokenResponse(
            token=access_token,
            email=user.email,
            refresh_token=new_refresh,
        )

    async def logout(self, user_id: str) -> None:
        import uuid
        await self.token_repo.revoke_all_for_user(uuid.UUID(user_id))

    # ── Private ───────────────────────────────────────────────────────────────
    async def _issue_refresh_token(self, user_id: str) -> str:
        import uuid as uuid_mod
        raw = create_refresh_token(user_id)
        expires = datetime.now(tz=timezone.utc) + timedelta(
            days=settings.refresh_token_expire_days
        )
        await self.token_repo.create(
            user_id=uuid_mod.UUID(user_id),
            token=raw,
            expires_at=expires,
            created_at=datetime.now(tz=timezone.utc),
        )
        return raw
