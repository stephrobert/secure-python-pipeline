# Description

Résumez le changement et la motivation. Reliez l'issue concernée.

Closes #

## Type de changement

- [ ] Correction de bug (non cassant)
- [ ] Nouvelle fonctionnalité (non cassante)
- [ ] Changement cassant (comportement existant modifié)
- [ ] Documentation
- [ ] Chaîne CI/CD ou sécurité

## Checklist

- [ ] `ruff check .` passe
- [ ] `pytest` passe
- [ ] `bandit -r src` sans finding
- [ ] Les actions ajoutées sont épinglées par SHA de commit
- [ ] Aucun secret en clair introduit
- [ ] La documentation est à jour si nécessaire

## Tests effectués

Décrivez comment le changement a été vérifié.
