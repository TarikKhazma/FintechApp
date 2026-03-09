from pydantic import BaseModel, EmailStr, field_validator, model_validator


# ── Request schemas ────────────────────────────────────────────────────────────

class SignupRequest(BaseModel):
    email: EmailStr
    password: str
    confirmPassword: str  # camelCase — matches Flutter's jsonEncode field name

    @field_validator("password")
    @classmethod
    def password_strength(cls, v: str) -> str:
        if len(v) < 8:
            raise ValueError("Password must be at least 8 characters")
        return v

    @model_validator(mode="after")
    def passwords_match(self) -> "SignupRequest":
        if self.password != self.confirmPassword:
            raise ValueError("Passwords do not match")
        return self


class SigninRequest(BaseModel):
    email: EmailStr
    password: str


# ── Response schemas ───────────────────────────────────────────────────────────

class AuthResponse(BaseModel):
    """Matches AuthModel.fromJson in Flutter: {token, email}"""
    token: str
    email: str


class MessageResponse(BaseModel):
    """Used for error responses — Flutter reads data['message']"""
    message: str
