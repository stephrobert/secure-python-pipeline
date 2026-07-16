"""API de démonstration pour un pipeline supply chain sécurisé."""

from importlib import metadata

from fastapi import FastAPI

try:
    _VERSION = metadata.version("secure-python-pipeline")
except metadata.PackageNotFoundError:  # pragma: no cover - hors paquet installé
    _VERSION = "1.0.0"

app = FastAPI(
    title="Secure Python Pipeline Demo",
    version=_VERSION,
    description="Application de démonstration avec supply chain sécurisée",
)


@app.get("/")
async def root() -> dict[str, str]:
    """Endpoint racine."""
    return {"message": "Hello, Secure World!"}


@app.get("/health")
async def health() -> dict[str, str]:
    """Sonde de santé pour les probes Kubernetes."""
    return {"status": "healthy"}


@app.get("/version")
async def version() -> dict[str, str]:
    """Version applicative, utile pour tracer une image jusqu'à sa provenance."""
    return {"version": _VERSION}
