import pytest
from httpx import AsyncClient

pytestmark = pytest.mark.asyncio

TRANSACTIONS_URL = "/api/v1/transactions"
DEPOSIT_URL = "/api/v1/wallet/deposit"
SIGNUP_URL = "/api/v1/auth/signup"


async def _fund_wallet(client: AsyncClient, headers: dict, amount: str = "500.00") -> None:
    await client.post(DEPOSIT_URL, json={"amount": amount}, headers=headers)


class TestListTransactions:
    async def test_list_empty(self, client: AsyncClient, auth_headers: dict):
        resp = await client.get(TRANSACTIONS_URL, headers=auth_headers)
        assert resp.status_code == 200
        body = resp.json()
        assert body["ok"] is True
        assert isinstance(body["data"]["items"], list)
        assert "meta" in body["data"]

    async def test_list_after_deposit(self, client: AsyncClient, auth_headers: dict):
        await _fund_wallet(client, auth_headers)
        resp = await client.get(TRANSACTIONS_URL, headers=auth_headers)
        assert resp.status_code == 200
        items = resp.json()["data"]["items"]
        assert len(items) >= 1

    async def test_list_pagination(self, client: AsyncClient, auth_headers: dict):
        # Seed multiple deposits
        for _ in range(3):
            await _fund_wallet(client, auth_headers, "10.00")

        resp = await client.get(f"{TRANSACTIONS_URL}?page=1&page_size=2", headers=auth_headers)
        assert resp.status_code == 200
        body = resp.json()
        assert len(body["data"]["items"]) <= 2
        assert body["data"]["meta"]["page"] == 1

    async def test_list_filter_by_type(self, client: AsyncClient, auth_headers: dict):
        await _fund_wallet(client, auth_headers)
        resp = await client.get(f"{TRANSACTIONS_URL}?type=deposit", headers=auth_headers)
        assert resp.status_code == 200
        for item in resp.json()["data"]["items"]:
            assert item["type"] == "deposit"

    async def test_list_unauthenticated(self, client: AsyncClient):
        resp = await client.get(TRANSACTIONS_URL)
        assert resp.status_code == 401


class TestGetTransaction:
    async def test_get_by_id_success(self, client: AsyncClient, auth_headers: dict):
        await _fund_wallet(client, auth_headers)
        list_resp = await client.get(TRANSACTIONS_URL, headers=auth_headers)
        tx_id = list_resp.json()["data"]["items"][0]["id"]

        resp = await client.get(f"{TRANSACTIONS_URL}/{tx_id}", headers=auth_headers)
        assert resp.status_code == 200
        assert resp.json()["data"]["id"] == tx_id

    async def test_get_nonexistent(self, client: AsyncClient, auth_headers: dict):
        fake_id = "00000000-0000-0000-0000-000000000000"
        resp = await client.get(f"{TRANSACTIONS_URL}/{fake_id}", headers=auth_headers)
        assert resp.status_code == 404

    async def test_get_other_user_transaction(self, client: AsyncClient, auth_headers: dict):
        # Create another user with their own deposit
        other_payload = {
            "email": "other_tx@example.com",
            "full_name": "Other User",
            "password": "SecurePass1!",
            "confirm_password": "SecurePass1!",
        }
        other_signup = await client.post(SIGNUP_URL, json=other_payload)
        other_token = other_signup.json()["data"]["token"]
        other_headers = {"Authorization": f"Bearer {other_token}"}
        await _fund_wallet(client, other_headers)

        other_list = await client.get(TRANSACTIONS_URL, headers=other_headers)
        other_tx_id = other_list.json()["data"]["items"][0]["id"]

        # First user should not see other user's transaction
        resp = await client.get(f"{TRANSACTIONS_URL}/{other_tx_id}", headers=auth_headers)
        assert resp.status_code == 404

    async def test_get_unauthenticated(self, client: AsyncClient):
        resp = await client.get(f"{TRANSACTIONS_URL}/some-id")
        assert resp.status_code == 401
