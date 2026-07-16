"""Tests de l'API."""

from fastapi.testclient import TestClient

from app.main import app

client = TestClient(app)


def test_root() -> None:
    """L'endpoint racine répond 200 avec le message attendu."""
    response = client.get("/")
    assert response.status_code == 200
    assert response.json() == {"message": "Hello, Secure World!"}


def test_health() -> None:
    """La sonde de santé répond 200 et signale l'état healthy."""
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json()["status"] == "healthy"


def test_version() -> None:
    """L'endpoint version expose une chaîne de version non vide."""
    response = client.get("/version")
    assert response.status_code == 200
    assert response.json()["version"]
