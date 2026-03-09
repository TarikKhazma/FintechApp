import pytest
from httpx import AsyncClient

pytestmark = pytest.mark.asyncio

ME_URL = "/api/v1/users/me"
CHANGE_PASSWORD_URL = "/api/v1/users/me/change-password"


class TestGetMe:
    async def test_get_me_success(self, client: AsyncClient, auth_headers: dict):
        resp = await client.get(ME_URL, headers=auth_headers)
        assert resp.status_code == 200
        body = resp.json()
        assert body["ok"] is True
        assert "email" in body["data"]
        assert "password_hash" not in body["data"]

    async def test_get_me_unauthenticated(self, client: AsyncClient):
        resp = await client.get(ME_URL)
        assert resp.status_code == 401


class TestUpdateMe:
    async def test_update_full_name(self, client: AsyncClient, auth_headers: dict):
        resp = await client.patch(
            ME_URL,
            json={"full_name": "Updated Name"},
            headers=auth_headers,
        )
        assert resp.status_code == 200
        assert resp.json()["data"]["full_name"] == "Updated Name"

    async def test_update_me_unauthenticated(self, client: AsyncClient):
        resp = await client.patch(ME_URL, json={"full_name": "Ghost"})
        assert resp.status_code == 401


class TestChangePassword:
    async def test_change_password_success(self, client: AsyncClient, auth_headers: dict):
        resp = await client.post(
            CHANGE_PASSWORD_URL,
            json={
                "current_password": "SecurePass1!",
                "new_password": "NewSecure2@",
                "confirm_new_password": "NewSecure2@",
            },
            headers=auth_headers,
        )
        assert resp.status_code == 200
        assert resp.json()["ok"] is True

    async def test_change_password_wrong_current(self, client: AsyncClient, auth_headers: dict):
        resp = await client.post(
            CHANGE_PASSWORD_URL,
            json={
                "current_password": "WrongCurrent!",
                "new_password": "NewSecure2@",
                "confirm_new_password": "NewSecure2@",
            },
            headers=auth_headers,
        )
        assert resp.status_code == 400

    async def test_change_password_mismatch(self, client: AsyncClient, auth_headers: dict):
        resp = await client.post(
            CHANGE_PASSWORD_URL,
            json={
                "current_password": "SecurePass1!",
                "new_password": "NewSecure2@",
                "confirm_new_password": "DifferentPass3#",
            },
            headers=auth_headers,
        )
        assert resp.status_code == 422

    async def test_change_password_unauthenticated(self, client: AsyncClient):
        resp = await client.post(CHANGE_PASSWORD_URL, json={})
        assert resp.status_code == 401
