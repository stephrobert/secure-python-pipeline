# Politique de sécurité

Ce dépôt est un lab pédagogique qui démontre une chaîne d'approvisionnement
logicielle sécurisée sur GitHub Actions. Il applique les pratiques qu'il enseigne.

## Versions supportées

| Version | Supportée |
|---------|-----------|
| 1.x     | Oui       |
| < 1.0   | Non       |

## Signaler une vulnérabilité

Nous pratiquons la **divulgation coordonnée** (coordinated disclosure). Merci de
**ne pas** ouvrir d'issue publique pour une vulnérabilité.

Deux canaux privés pour signaler une vulnérabilité :

- **De préférence**, via l'avis de sécurité privé GitHub :
  <https://github.com/stephrobert/secure-python-pipeline/security/advisories/new>
- Par courriel, à l'adresse : **security@stephane-robert.info**

Merci d'inclure une description de la vulnérabilité, les étapes de reproduction,
la version ou le digest de l'image concernée, et l'impact estimé.

## Engagements de délai

Pour toute vulnérabilité signalée, nous nous engageons sur les délais suivants :

- **Accusé de réception** sous **48 heures**.
- **Évaluation initiale** et première réponse sous **5 jours** ouvrés.
- **Correctif ou plan de remédiation** communiqué sous **30 jours**, plus tôt
  selon la gravité.
- **Divulgation publique coordonnée** après correctif, dans un délai maximum de
  **90 jours** à compter du signalement (coordinated disclosure window).

Nous créditons publiquement les personnes qui signalent une vulnérabilité de
manière responsable, sauf demande contraire de leur part.

## Garanties de la chaîne de build

Chaque image publiée sur `ghcr.io` est accompagnée de :

- une **attestation de provenance SLSA** signée (Sigstore keyless, log Rekor) ;
- un **SBOM** (CycloneDX et SPDX) attaché au registre ;
- une **signature Cosign** vérifiable du digest ;
- un fichier **`provenance.intoto.jsonl`** attaché à chaque release.

La procédure de vérification est décrite dans le [README](README.md).
