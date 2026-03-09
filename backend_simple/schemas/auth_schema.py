from pydantic import BaseModel, EmailStr


class SignupRequest(BaseModel):
    email: EmailStr
    password: str
    confirmPassword: str


class LoginRequest(BaseModel):
    email: EmailStr
    password: str


class SignupResponse(BaseModel):
    success: bool
    message: str


class LoginResponse(BaseModel):
    success: bool
    access_token: str
    token_type: str = "bearer"
