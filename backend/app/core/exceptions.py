from fastapi import HTTPException, status


class AppException(HTTPException):
    """Base application exception."""
    def __init__(self, status_code: int, message: str):
        super().__init__(status_code=status_code, detail=message)


# ── 400 ──────────────────────────────────────────────────────────────────────
class BadRequestError(AppException):
    def __init__(self, message: str = "Bad request"):
        super().__init__(status.HTTP_400_BAD_REQUEST, message)


# ── 401 ──────────────────────────────────────────────────────────────────────
class UnauthorizedError(AppException):
    def __init__(self, message: str = "Not authenticated"):
        super().__init__(status.HTTP_401_UNAUTHORIZED, message)


class InvalidCredentialsError(UnauthorizedError):
    def __init__(self):
        super().__init__("Invalid email or password")


class TokenExpiredError(UnauthorizedError):
    def __init__(self):
        super().__init__("Token has expired")


# ── 403 ──────────────────────────────────────────────────────────────────────
class ForbiddenError(AppException):
    def __init__(self, message: str = "Forbidden"):
        super().__init__(status.HTTP_403_FORBIDDEN, message)


# ── 404 ──────────────────────────────────────────────────────────────────────
class NotFoundError(AppException):
    def __init__(self, resource: str = "Resource"):
        super().__init__(status.HTTP_404_NOT_FOUND, f"{resource} not found")


# ── 409 ──────────────────────────────────────────────────────────────────────
class ConflictError(AppException):
    def __init__(self, message: str = "Resource already exists"):
        super().__init__(status.HTTP_409_CONFLICT, message)


# ── 422 ──────────────────────────────────────────────────────────────────────
class ValidationError(AppException):
    def __init__(self, message: str):
        super().__init__(status.HTTP_422_UNPROCESSABLE_ENTITY, message)


# ── 503 ──────────────────────────────────────────────────────────────────────
class InsufficientFundsError(AppException):
    def __init__(self):
        super().__init__(status.HTTP_422_UNPROCESSABLE_ENTITY, "Insufficient funds")


class WalletFrozenError(AppException):
    def __init__(self):
        super().__init__(status.HTTP_403_FORBIDDEN, "Wallet is frozen")
