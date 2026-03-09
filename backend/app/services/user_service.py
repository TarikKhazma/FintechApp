import uuid
from sqlalchemy.ext.asyncio import AsyncSession
from app.core.exceptions import NotFoundError, ConflictError, BadRequestError
from app.core.security import verify_password, hash_password
from app.models.user import User
from app.repositories.user_repository import UserRepository
from app.schemas.user import UserUpdateRequest, ChangePasswordRequest


class UserService:
    def __init__(self, db: AsyncSession):
        self.repo = UserRepository(db)

    async def get_by_id(self, user_id: uuid.UUID) -> User:
        user = await self.repo.get_by_id(user_id)
        if not user:
            raise NotFoundError("User")
        return user

    async def list_users(
        self, page: int = 1, page_size: int = 20
    ) -> tuple[list[User], int]:
        offset = (page - 1) * page_size
        items, total = await self.repo.get_all(offset=offset, limit=page_size)
        return list(items), total

    async def update_profile(
        self, user: User, payload: UserUpdateRequest
    ) -> User:
        updates = payload.model_dump(exclude_none=True)

        if "phone" in updates and updates["phone"]:
            existing = await self.repo.get_by_phone(updates["phone"])
            if existing and existing.id != user.id:
                raise ConflictError("Phone number already in use")

        return await self.repo.update(user, **updates)

    async def change_password(
        self, user: User, payload: ChangePasswordRequest
    ) -> None:
        if not verify_password(payload.current_password, user.password_hash):
            raise BadRequestError("Current password is incorrect")
        if payload.new_password != payload.confirm_new_password:
            raise BadRequestError("New passwords do not match")
        await self.repo.update(user, password_hash=hash_password(payload.new_password))
