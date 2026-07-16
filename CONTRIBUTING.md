# Contribuer

Merci de votre intérêt pour ce lab. Il sert de référence à une formation sur la
sécurité des pipelines : chaque contribution doit rester exemplaire.

## Prérequis

- Python 3.11 ou supérieur
- Docker 24 ou supérieur
- `uv` (ou `pip` + `pip-tools`)

## Installation locale

```bash
git clone https://github.com/stephrobert/secure-python-pipeline.git
cd secure-python-pipeline
uv venv .venv && source .venv/bin/activate
uv pip install --require-hashes -r requirements.txt
uv pip install -r requirements-dev.txt
```

## Lancer les vérifications

```bash
ruff check .          # lint
pytest                # tests
bandit -r src         # analyse statique de sécurité
pip-audit -r requirements.txt   # vulnérabilités des dépendances
```

## Règles non négociables

- Toute **action GitHub** est épinglée par **SHA de commit 40 caractères**,
  suivi d'un commentaire `# vX.Y.Z`. Jamais `@v4`, jamais `@main`.
- Les **images** sont épinglées par digest `@sha256:`.
- Les **dépendances Python** passent par `requirements.in` puis
  `pip-compile --generate-hashes`. On ne modifie jamais `requirements.txt` à la main.
- Aucun **secret en clair** dans le code ou les workflows.

## Processus

1. Créez une branche depuis `main`.
2. Ouvrez une pull request en remplissant le gabarit.
3. La CI doit être verte et la revue d'un CODEOWNER est requise avant fusion.
