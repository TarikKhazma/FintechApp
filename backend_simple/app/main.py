from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from pydantic import ValidationError

from .database import Base, engine
from .routers import auth

# Create tables on startup (use Alembic for production migrations)
Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="FintechApp Auth API",
    version="1.0.0",
    description="Authentication API — matches Flutter view/auth client",
)

# ── CORS — allow Flutter app (any origin in dev) ──────────────────────────────
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],          # restrict to your domain in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ── Validation error → Flutter-friendly {message: ...} ───────────────────────
@app.exception_handler(ValidationError)
async def validation_exception_handler(request: Request, exc: ValidationError):
    first_error = exc.errors()[0]
    return JSONResponse(
        status_code=422,
        content={"message": first_error["msg"]},
    )


# ── Routers ───────────────────────────────────────────────────────────────────
app.include_router(auth.router)


@app.get("/health")
def health():
    return {"status": "ok"}
