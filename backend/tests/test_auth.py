import pytest
from httpx import AsyncClient

pytestmark = pytest.mark.asyncio


SIGNUP_URL = "/api/v1/auth/signup"
SIGNIN_URL = "/api/v1/auth/signin"
REFRESH_URL = "/api/v1/auth/refresh"
LOGOUT_URL = "/api/v1/auth/logout"

VALID_PAYLOAD = {
    "email": "auth_test@example.com",
    "full_name": "Auth Tester",
    "password": "SecurePass1!",
    "confirm_password": "SecurePass1!",
}


class TestSignUp:
    async def test_signup_success(self, client: AsyncClient):
        resp = await client.post(SIGNUP_URL, json=VALID_PAYLOAD)
        assert resp.status_code == 201
        body = resp.json()
        assert body["ok"] is True
        assert "token" in body["data"]
        assert body["data"]["email"] == VALID_PAYLOAD["email"]

    async def test_signup_duplicate_email(self, client: AsyncClient):
        await client.post(SIGNUP_URL, json=VALID_PAYLOAD)
        resp = await client.post(SIGNUP_URL, json=VALID_PAYLOAD)
        assert resp.status_code == 409

    async def test_signup_password_mismatch(self, client: AsyncClient):
        payload = {**VALID_PAYLOAD, "email": "mismatch@example.com", "confirm_password": "Wrong1!"}
        resp = await client.post(SIGNUP_URL, json=payload)
        assert resp.status_code == 422

    async def test_signup_weak_password(self, client: AsyncClient):
        payload = {**VALID_PAYLOAD, "email": "weak@example.com", "password": "short", "confirm_password": "short"}
        resp = await client.post(SIGNUP_URL, json=payload)
        assert resp.status_code == 422

    async def test_signup_invalid_email(self, client: AsyncClient):
        payload = {**VALID_PAYLOAD, "email": "not-an-email"}
        resp = await client.post(SIGNUP_URL, json=payload)
        assert resp.status_code == 422


class TestSignIn:
    async def test_signin_success(self, client: AsyncClient):
        await client.post(SIGNUP_URL, json=VALID_PAYLOAD)
        resp = await client.post(
            SIGNIN_URL,
            json={"email": VALID_PAYLOAD["email"], "password": VALID_PAYLOAD["password"]},
        )
        assert resp.status_code == 200
        body = resp.json()
        assert body["ok"] is True
        assert "token" in body["data"]

    async def test_signin_wrong_password(self, client: AsyncClient):
        await client.post(SIGNUP_URL, json=VALID_PAYLOAD)
        resp = await client.post(
            SIGNIN_URL,
            json={"email": VALID_PAYLOAD["email"], "password": "WrongPass1!"},
        )
        assert resp.status_code == 401

    async def test_signin_nonexistent_user(self, client: AsyncClient):
        resp = await client.post(
            SIGNIN_URL,
            json={"email": "nobody@example.com", "password": "Pass1234!"},
        )
        assert resp.status_code == 401

    async def test_signin_missing_fields(self, client: AsyncClient):
        resp = await client.post(SIGNIN_URL, json={"email": "x@x.com"})
        assert resp.status_code == 422


class TestRefreshAndLogout:
    async def test_refresh_token(self, client: AsyncClient):
        await client.post(SIGNUP_URL, json=VALID_PAYLOAD)
        signin_resp = await client.post(
            SIGNIN_URL,
            json={"email": VALID_PAYLOAD["email"], "password": VALID_PAYLOAD["password"]},
        )
        refresh_token = signin_resp.json()["data"]["refresh_token"]
        resp = await client.post(REFRESH_URL, json={"refresh_token": refresh_token})
        assert resp.status_code == 200
        assert "token" in resp.json()["data"]

    async def test_refresh_invalid_token(self, client: AsyncClient):
        resp = await client.post(REFRESH_URL, json={"refresh_token": "invalid.token.here"})
        assert resp.status_code == 401

    async def test_logout(self, client: AsyncClient, auth_headers: dict):
        resp = await client.post(LOGOUT_URL, headers=auth_headers)
        assert resp.status_code == 200
        assert resp.json()["ok"] is True

    async def test_logout_requires_auth(self, client: AsyncClient):
        resp = await client.post(LOGOUT_URL)
        assert resp.status_code == 401
