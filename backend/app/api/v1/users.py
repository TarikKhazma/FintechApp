import uuid
from fastapi import APIRouter, Depends, status
from sqlalchemy.ext.asyncio import AsyncSession
from app.db.session import get_db
from app.core.dependencies import get_current_user, get_current_admin, pagination_params
from app.models.user import User
from app.schemas.user import UserResponse, UserUpdateRequest, ChangePasswordRequest
from app.schemas.common import ApiResponse, PaginatedResponse, PaginationMeta
from app.services.user_service import UserService

router = APIRouter(prefix="/users", tags=["Users"])


@router.get(
    "/me",
    response_model=ApiResponse[UserResponse],
    summary="Get the currently authenticated user's profile",
)
async def get_me(current_user: User = Depends(get_current_user)):
    return ApiResponse.ok(UserResponse.model_validate(current_user))


@router.patch(
    "/me",
    response_model=ApiResponse[UserResponse],
    summary="Update profile (name, phone)",
)
async def update_me(
    payload: UserUpdateRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    service = UserService(db)
    updated = await service.update_profile(current_user, payload)
    return ApiResponse.ok(UserResponse.model_validate(updated))


@router.post(
    "/me/change-password",
    response_model=ApiResponse[None],
    status_code=status.HTTP_200_OK,
    summary="Change the current user's password",
)
async def change_password(
    payload: ChangePasswordRequest,
    current_user: User = Depends(get_current_user),
    db: AsyncSession = Depends(get_db),
):
    service = UserService(db)
    await service.change_password(current_user, payload)
    return ApiResponse.ok(None, "Password changed successfully")


# ── Admin routes ──────────────────────────────────────────────────────────────

@router.get(
    "",
    response_model=PaginatedResponse[UserResponse],
    summary="[Admin] List all users",
)
async def list_users(
    pagination: dict = Depends(pagination_params),
    _admin: User = Depends(get_current_admin),
    db: AsyncSession = Depends(get_db),
):
    service = UserService(db)
    users, total = await service.list_users(
        page=pagination["page"], page_size=pagination["page_size"]
    )
    total_pages = -(-total // pagination["page_size"])
    return PaginatedResponse(
        data=[UserResponse.model_validate(u) for u in users],
        meta=PaginationMeta(
            total=total,
            page=pagination["page"],
            page_size=pagination["page_size"],
            total_pages=total_pages,
        ),
    )


@router.get(
    "/{user_id}",
    response_model=ApiResponse[UserResponse],
    summary="[Admin] Get user by ID",
)
async def get_user(
    user_id: uuid.UUID,
    _admin: User = Depends(get_current_admin),
    db: AsyncSession = Depends(get_db),
):
    service = UserService(db)
    user = await service.get_by_id(user_id)
    return ApiResponse.ok(UserResponse.model_validate(user))
