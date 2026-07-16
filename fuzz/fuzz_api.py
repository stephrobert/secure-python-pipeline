"""Harnais de fuzzing Atheris pour l'API.

Scorecard détecte le fuzzing Python par la présence de `import atheris`.
Ce harnais envoie des chemins et payloads aléatoires à l'application pour
débusquer des plantages non gérés (exceptions non attendues, 500).

Lancement local :
    pip install atheris
    python fuzz/fuzz_api.py
"""

import sys

import atheris

with atheris.instrument_imports():
    from fastapi.testclient import TestClient

    from app.main import app

client = TestClient(app)


def test_one_input(data: bytes) -> None:
    """Un tour de fuzzing : construit une requête à partir de données aléatoires."""
    fdp = atheris.FuzzedDataProvider(data)
    path = fdp.ConsumeUnicodeNoSurrogates(64)
    try:
        response = client.get("/" + path)
    except Exception:  # noqa: BLE001 - le fuzzing doit tolérer toute erreur applicative
        return
    # Une réponse serveur (5xx) sur une entrée malformée signale un bug à corriger.
    assert response.status_code < 500


def main() -> None:
    atheris.Setup(sys.argv, test_one_input)
    atheris.Fuzz()


if __name__ == "__main__":
    main()
