from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.core.dependencies import get_current_user
from app.models.user import User
from app.schemas.auth import SignUpRequest, SignInRequest, RefreshTokenRequest, AuthTokenResponse
from app.schemas.common import ApiResponse
from app.services.auth_service import AuthService

router = APIRouter(prefix="/auth", tags=["Auth"])


@router.post(
    "/signup",
    response_model=ApiResponse[AuthTokenResponse],
    status_code=status.HTTP_201_CREATED,
    summary="Register a new user",
)
async def signup(
    payload: SignUpRequest,
    db: AsyncSession = Depends(get_db),
):
    service = AuthService(db)
    result = await service.signup(payload)
    return ApiResponse.ok(result, "Account created successfully")


@router.post(
    "/signin",
    response_model=ApiResponse[AuthTokenResponse],
    summary="Sign in and receive JWT tokens",
)
async def signin(
    payload: SignInRequest,
    db: AsyncSession = Depends(get_db),
):
    service = AuthService(db)
    result = await service.signin(payload)
    return ApiResponse.ok(result, "Signed in successfully")


@router.post(
    "/refresh",
    response_model=ApiResponse[AuthTokenResponse],
    summary="Exchange a refresh token for a new access token",
)
async def refresh_token(
    payload: RefreshTokenRequest,
    db: AsyncSession = Depends(get_db),
):
    service = AuthService(db)
    result = await service.refresh(payload.refresh_token)
    return ApiResponse.ok(result)


@router.post(
    "/logout",
    response_model=ApiResponse[None],
    summary="Revoke all refresh tokens (sign out from all devices)",
)
async def logout(
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    service = AuthService(db)
    await service.logout(str(current_user.id))
    return ApiResponse.ok(None, "Logged out successfully")
