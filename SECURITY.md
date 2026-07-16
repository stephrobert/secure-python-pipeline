# Politique de sécurité

Ce dépôt est un lab pédagogique qui démontre une chaîne d'approvisionnement
logicielle sécurisée sur GitHub Actions. Il applique les pratiques qu'il enseigne.

## Versions supportées

| Version | Supportée |
|---------|-----------|
| 1.x     | Oui       |
| < 1.0   | Non       |

## Signaler une vulnérabilité

Utilisez l'onglet **Security > Report a vulnerability** du dépôt (GitHub Private
Vulnerability Reporting). En l'absence de cette option, ouvrez une issue **sans
détail exploitable** et demandez un canal privé.

Délais indicatifs :

- Accusé de réception sous 48 heures.
- Évaluation initiale sous 5 jours ouvrés.
- Correctif ou plan de remédiation communiqué selon la gravité.

## Garanties de la chaîne de build

Chaque image publiée sur `ghcr.io` est accompagnée de :

- une **attestation de provenance SLSA** signée (Sigstore keyless, log Rekor) ;
- un **SBOM** (CycloneDX et SPDX) attaché au registre ;
- une **signature Cosign** vérifiable du digest.

La vérification est décrite dans le README.
