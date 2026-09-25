# secure-python-pipeline

**Language:** [English](README.md) · [Français](README.fr.md)

[![CI](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/ci.yml/badge.svg)](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/ci.yml)
[![CodeQL](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/codeql.yml/badge.svg)](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/codeql.yml)
[![Scorecard](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/scorecard.yml/badge.svg)](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/scorecard.yml)
[![Plumber](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/plumber.yml/badge.svg)](https://github.com/stephrobert/secure-python-pipeline/actions/workflows/plumber.yml)
[![OpenSSF Scorecard](https://api.securityscorecards.dev/projects/github.com/stephrobert/secure-python-pipeline/badge)](https://scorecard.dev/viewer/?uri=github.com/stephrobert/secure-python-pipeline)
[![Plumber Score](https://score.getplumber.io/github.com/stephrobert/secure-python-pipeline.svg)](https://score.getplumber.io/github.com/stephrobert/secure-python-pipeline)
[![SLSA 3](https://slsa.dev/images/gh-badge-level3.svg)](https://slsa.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

**A reference for the security of a GitHub Actions CI/CD pipeline.** This
repository shows, on a deliberately minimal Python API (FastAPI), what a
software supply chain secured **end to end** looks like: strict pinning,
minimal permissions, hardened image, signed SLSA provenance, attested SBOM,
and a pipeline that aims for the maximum score on every security report
(OpenSSF Scorecard, Plumber, zizmor, poutine, actionlint, Trivy).

It is the hands-on companion to the training on the blog (in French):

- [GitHub Actions training](https://blog.stephane-robert.info/docs/pipeline-cicd/github/): the full course.
- [Securing your pipelines](https://blog.stephane-robert.info/docs/pipeline-cicd/github/securite/): the security part (SHA pinning, permissions, OIDC, attestations).
- [End-to-end secure pipeline lab](https://blog.stephane-robert.info/docs/pipeline-cicd/github/securite/lab-pipeline-securise/): the step-by-step guide that builds this repository.

Every technical choice in this repository is explained in those guides: it is
not meant to be copied as is, but to be **understood**.

## What the pipeline guarantees

- **Lint, tests and SAST** (ruff, pytest, bandit) on every push and pull request.
- **Dependency audit** (pip-audit, OSV-Scanner) and **image scan** (Trivy).
- **Pinned dependencies**: actions by SHA, base image by digest, Python
  packages by hash (`--require-hashes`).
- **Hardened image**: multi-stage, non-root user, build tools removed.
- **SLSA provenance** and **SBOM** (CycloneDX + SPDX) attested natively by
  GitHub, **signed** with Sigstore keyless (Rekor transparency log).

## Quick start

```bash
docker run --rm -p 8000:8000 ghcr.io/stephrobert/secure-python-pipeline:latest
curl http://localhost:8000/health   # {"status":"healthy"}
```

## Develop

```bash
uv venv .venv && source .venv/bin/activate
uv pip install --require-hashes -r requirements.txt
uv pip install -r requirements-dev.txt
ruff check . && pytest --cov && bandit -r src
```

## Verify the provenance of an image

Every published image carries a signed provenance attestation. To verify it:

```bash
# Build provenance (native GitHub attestation)
gh attestation verify oci://ghcr.io/stephrobert/secure-python-pipeline:latest \
  --owner stephrobert

# Cosign keyless signature (workflow identity + OIDC issuer)
cosign verify ghcr.io/stephrobert/secure-python-pipeline:latest \
  --certificate-identity-regexp "https://github.com/stephrobert/secure-python-pipeline/.github/workflows/release.yml@.*" \
  --certificate-oidc-issuer "https://token.actions.githubusercontent.com"
```

As the repository is public, these attestations can be verified by a third
party through the public Rekor log.

## Contributing and reporting

Bug reports, questions and comments are welcome in English or French on the
[issue tracker](https://github.com/stephrobert/secure-python-pipeline/issues).
Vulnerabilities are reported privately: see [SECURITY.md](SECURITY.md).

## License

MIT. See [LICENSE](LICENSE).
