from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session

from ..database import get_db
from ..schemas import AuthResponse, SigninRequest, SignupRequest
from ..services import auth_service

router = APIRouter(prefix="/auth", tags=["auth"])


@router.post(
    "/signup",
    response_model=AuthResponse,
    status_code=status.HTTP_201_CREATED,
    summary="Register a new user",
)
def signup(body: SignupRequest, db: Session = Depends(get_db)):
    """
    Flutter calls: POST /auth/signup
    Body: {email, password, confirmPassword}
    Returns: {token, email}
    """
    try:
        result = auth_service.signup(
            db=db,
            email=body.email,
            password=body.password,
        )
        return result
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail={"message": str(e)},
        )


@router.post(
    "/signin",
    response_model=AuthResponse,
    status_code=status.HTTP_200_OK,
    summary="Sign in with email and password",
)
def signin(body: SigninRequest, db: Session = Depends(get_db)):
    """
    Flutter calls: POST /auth/signin
    Body: {email, password}
    Returns: {token, email}
    """
    try:
        result = auth_service.signin(
            db=db,
            email=body.email,
            password=body.password,
        )
        return result
    except ValueError as e:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail={"message": str(e)},
        )
