# CLAUDE.md

## Projet
Portfolio DevOps : infrastructure as code (Terraform) + pipelines CI/CD (GitHub Actions)
pour une application Node.js déployée sur AWS. Publié sur GitHub public.

## Commandes utiles
- Lint : `make lint`
- Tests : `make test`
- Plan Terraform : `terraform -chdir=infra plan`
- Ne jamais lancer `terraform apply` ou `terraform destroy` sans demande explicite.

## Conventions
- Langue des commits, README et commentaires : français.
- Commits au format Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`).
- Une ressource Terraform = un fichier dans `infra/modules/`.
- Aucun secret en clair : utiliser AWS SSM Parameter Store ou GitHub Secrets.

## Règles de travail
- Avant de modifier du code, proposer le plan en 3 lignes maximum et attendre validation.
- Après chaque modification Terraform, lancer `terraform fmt` et `terraform validate`.
- Signaler tout changement qui augmente le coût cloud (nouvelle instance, NAT Gateway, etc.).

## Fichiers à ne pas modifier
- `infra/backend.tf` (état distant, géré manuellement)
- `_archive/` (anciennes versions, lecture seule)
