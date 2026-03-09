import uuid
from fastapi import Depends
from fastapi.security import HTTPBearer, HTTPAuthorizationCredentials
from jose import JWTError
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.core.security import decode_token
from app.core.exceptions import UnauthorizedError, ForbiddenError, TokenExpiredError
from app.models.user import User

bearer_scheme = HTTPBearer(auto_error=False)


async def get_current_user(
    credentials: HTTPAuthorizationCredentials | None = Depends(bearer_scheme),
    db: AsyncSession = Depends(get_db),
) -> User:
    """
    Validate JWT and return the authenticated User.
    Raises 401 if token is missing, invalid or expired.
    """
    if not credentials:
        raise UnauthorizedError("Authorization header missing")

    try:
        payload = decode_token(credentials.credentials)
    except JWTError:
        raise TokenExpiredError()

    if payload.type != "access":
        raise UnauthorizedError("Invalid token type")

    # Lazy import to avoid circular dependency
    from app.repositories.user_repository import UserRepository
    repo = UserRepository(db)
    user = await repo.get_by_id(uuid.UUID(payload.sub))
    if not user:
        raise UnauthorizedError("User not found")
    if not user.is_active:
        raise ForbiddenError("Account is disabled")

    return user


async def get_current_admin(
    current_user: User = Depends(get_current_user),
) -> User:
    """Require admin role."""
    if not current_user.is_admin:
        raise ForbiddenError("Admin access required")
    return current_user


def pagination_params(page: int = 1, page_size: int = 20) -> dict:
    page = max(1, page)
    page_size = min(100, max(1, page_size))
    return {"page": page, "page_size": page_size, "offset": (page - 1) * page_size}
