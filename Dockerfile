# syntax=docker/dockerfile:1

# =============================================================================
# Stage 1 : builder - installe les dépendances vérifiées par hash dans un venv
# =============================================================================
FROM python:3.14-slim@sha256:d3400aa122fa42cf0af0dbe8ec3091b047eac5c8f7e3539f7135e86d855dc015 AS builder

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# --require-hashes refuse toute dépendance dont le hash ne correspond pas
RUN pip install --no-cache-dir --require-hashes -r requirements.txt

# Retire les outils de build (pip, setuptools, wheel) du venv runtime :
# ils portent régulièrement des CVE et ne servent pas à l'exécution.
RUN pip uninstall -y setuptools wheel pip

# =============================================================================
# Stage 2 : production - image minimale, utilisateur non-root
# =============================================================================
FROM python:3.14-slim@sha256:d3400aa122fa42cf0af0dbe8ec3091b047eac5c8f7e3539f7135e86d855dc015 AS production

LABEL org.opencontainers.image.source="https://github.com/stephrobert/secure-python-pipeline"
LABEL org.opencontainers.image.description="API Python avec supply chain securisee"
LABEL org.opencontainers.image.licenses="MIT"

RUN groupadd --gid 1000 appgroup && \
    useradd --uid 1000 --gid 1000 --shell /bin/false appuser

WORKDIR /app

# L'image de base embarque pip/setuptools/wheel dans /usr/local : ces outils de
# build portent des CVE et ne servent pas au runtime (on exécute depuis /opt/venv).
RUN python -m pip uninstall -y pip setuptools wheel jaraco.context 2>/dev/null || true; \
    rm -rf /usr/local/lib/python3.11/site-packages/pip* \
           /usr/local/lib/python3.11/site-packages/setuptools* \
           /usr/local/lib/python3.11/site-packages/wheel* \
           /usr/local/lib/python3.11/site-packages/pkg_resources \
           /usr/local/lib/python3.11/site-packages/_distutils_hack \
           /usr/local/lib/python3.11/site-packages/jaraco* \
           /usr/local/bin/pip*

COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONPATH="/app/src"

COPY --chown=appuser:appgroup src/ ./src/

USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:8000/health')" || exit 1

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
