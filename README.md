# secure-python-pipeline

[![CI](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/ci.yml/badge.svg)](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/ci.yml)
[![CodeQL](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/codeql.yml/badge.svg)](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/codeql.yml)
[![Scorecard](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/scorecard.yml/badge.svg)](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/scorecard.yml)
[![Plumber](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/plumber.yml/badge.svg)](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/plumber.yml)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/stephrobert/secure-python-pipeline/badge)](https://scorecard.dev/viewer/?uri=github.com/stephrobert/secure-python-pipeline)
[![Plumber Score](https://score.getplumber.io/github.com/stephrobert/secure-python-pipeline.svg)](https://score.getplumber.io/github.com/stephrobert/secure-python-pipeline)
[![SLSA 3](https://slsa.dev/images/gh-badge-level3.svg)](https://slsa.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Lab pédagogique : une API Python (FastAPI) accompagnée d'un pipeline GitHub
Actions qui applique une chaîne d'approvisionnement logicielle sécurisée de bout
en bout. Support de la formation [GitHub Actions](https://blog.stephane-robert.info/docs/pipeline-cicd/github/).

## Ce que le pipeline garantit

- **Lint, tests et SAST** (ruff, pytest, bandit) à chaque push et pull request.
- **Audit des dépendances** (pip-audit, OSV-Scanner) et **scan d'image** (Trivy).
- **Dépendances épinglées** : actions par SHA, image de base par digest, paquets
  Python par hash (`--require-hashes`).
- **Image durcie** : multi-stage, utilisateur non-root, outils de build retirés.
- **Provenance SLSA** et **SBOM** (CycloneDX + SPDX) attestés nativement par
  GitHub, **signés** via Sigstore keyless (log de transparence Rekor).

## Démarrage rapide

```bash
docker run --rm -p 8000:8000 ghcr.io/stephrobert/secure-python-pipeline:latest
curl http://localhost:8000/health   # {"status":"healthy"}
```

## Développer

```bash
uv venv .venv && source .venv/bin/activate
uv pip install --require-hashes -r requirements.txt
uv pip install -r requirements-dev.txt
ruff check . && pytest && bandit -r src
```

## Vérifier la provenance d'une image

Chaque image publiée porte une attestation de provenance signée. Pour la vérifier :

```bash
# Provenance de build (attestation native GitHub)
gh attestation verify oci://ghcr.io/stephrobert/secure-python-pipeline:latest \
  --owner stephrobert

# Signature Cosign keyless (identité du workflow + émetteur OIDC)
cosign verify ghcr.io/stephrobert/secure-python-pipeline:latest \
  --certificate-identity-regexp "https://github.com/stephrobert/secure-python-pipeline/.github/workflows/release.yml@.*" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com"
```

Le dépôt étant public, ces attestations sont vérifiables par un tiers via le log
Rekor public.

## Licence

MIT. Voir [LICENSE](LICENSE).
