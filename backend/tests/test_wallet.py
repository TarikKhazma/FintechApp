import pytest
from httpx import AsyncClient

pytestmark = pytest.mark.asyncio

WALLET_URL = "/api/v1/wallet"
DEPOSIT_URL = "/api/v1/wallet/deposit"
TRANSFER_URL = "/api/v1/wallet/transfer"
SIGNUP_URL = "/api/v1/auth/signup"
SIGNIN_URL = "/api/v1/auth/signin"


async def _create_user_token(client: AsyncClient, email: str) -> str:
    payload = {
        "email": email,
        "full_name": "Test User",
        "password": "SecurePass1!",
        "confirm_password": "SecurePass1!",
    }
    resp = await client.post(SIGNUP_URL, json=payload)
    return resp.json()["data"]["token"]


class TestGetWallet:
    async def test_get_wallet_success(self, client: AsyncClient, auth_headers: dict):
        resp = await client.get(WALLET_URL, headers=auth_headers)
        assert resp.status_code == 200
        body = resp.json()
        assert body["ok"] is True
        assert "balance" in body["data"]

    async def test_get_wallet_unauthenticated(self, client: AsyncClient):
        resp = await client.get(WALLET_URL)
        assert resp.status_code == 401


class TestDeposit:
    async def test_deposit_success(self, client: AsyncClient, auth_headers: dict):
        resp = await client.post(
            DEPOSIT_URL,
            json={"amount": "500.00"},
            headers=auth_headers,
        )
        assert resp.status_code == 200
        body = resp.json()
        assert body["ok"] is True
        assert float(body["data"]["balance"]) >= 500.00

    async def test_deposit_zero_amount(self, client: AsyncClient, auth_headers: dict):
        resp = await client.post(DEPOSIT_URL, json={"amount": "0"}, headers=auth_headers)
        assert resp.status_code == 422

    async def test_deposit_negative_amount(self, client: AsyncClient, auth_headers: dict):
        resp = await client.post(DEPOSIT_URL, json={"amount": "-100"}, headers=auth_headers)
        assert resp.status_code == 422

    async def test_deposit_unauthenticated(self, client: AsyncClient):
        resp = await client.post(DEPOSIT_URL, json={"amount": "100"})
        assert resp.status_code == 401


class TestTransfer:
    async def test_transfer_success(self, client: AsyncClient, auth_headers: dict):
        # Fund the sender first
        await client.post(DEPOSIT_URL, json={"amount": "1000.00"}, headers=auth_headers)

        # Create receiver
        receiver_token = await _create_user_token(client, "receiver_wallet@example.com")
        receiver_resp = await client.get(
            "/api/v1/users/me", headers={"Authorization": f"Bearer {receiver_token}"}
        )
        receiver_id = receiver_resp.json()["data"]["id"]

        resp = await client.post(
            TRANSFER_URL,
            json={"receiver_id": receiver_id, "amount": "100.00"},
            headers=auth_headers,
        )
        assert resp.status_code == 200
        assert resp.json()["ok"] is True

    async def test_transfer_insufficient_funds(self, client: AsyncClient, auth_headers: dict):
        receiver_token = await _create_user_token(client, "receiver_broke@example.com")
        receiver_resp = await client.get(
            "/api/v1/users/me", headers={"Authorization": f"Bearer {receiver_token}"}
        )
        receiver_id = receiver_resp.json()["data"]["id"]

        resp = await client.post(
            TRANSFER_URL,
            json={"receiver_id": receiver_id, "amount": "99999.00"},
            headers=auth_headers,
        )
        assert resp.status_code == 400

    async def test_transfer_to_self(self, client: AsyncClient, auth_headers: dict):
        me_resp = await client.get("/api/v1/users/me", headers=auth_headers)
        my_id = me_resp.json()["data"]["id"]

        resp = await client.post(
            TRANSFER_URL,
            json={"receiver_id": my_id, "amount": "10.00"},
            headers=auth_headers,
        )
        assert resp.status_code == 400

    async def test_transfer_unauthenticated(self, client: AsyncClient):
        resp = await client.post(TRANSFER_URL, json={"receiver_id": "any", "amount": "10"})
        assert resp.status_code == 401
