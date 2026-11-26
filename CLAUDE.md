# CLAUDE.md

## Project
DevOps portfolio: infrastructure as code (Terraform) + CI/CD pipelines (GitHub Actions)
for a Python (FastAPI) application deployed on AWS. Published on a public GitHub repository.
Current state: the repository is under construction. `infra/` is not versioned yet
(test fixtures in progress); Terraform modules, pipelines and the application are still to be written.

## Available commands
- `make lint` and `make test`: **placeholders** (they print "OK" without checking anything).
  Do not use them as evidence; replace them with real tools as soon as they exist.
- `terraform fmt`, `terraform validate`
- `terraform -chdir=infra plan`: only once `infra/` contains resources
  and AWS credentials are configured.
(Add a command here only once it actually exists.)

## Conventions
- Language of commits, README and comments: English.
- Commits follow Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`).
- No plaintext secrets: use AWS SSM Parameter Store or GitHub Secrets.
- Target structure: one Terraform resource = one file in `infra/modules/`
  (folder to be created with the first module).

## Docker
- Base image with a pinned version (e.g. `python:3.12-slim`), never `latest`.
- Multi-stage build: build tools must not end up in the final image.
- The container runs as a non-root user.
- A `.dockerignore` is mandatory and excludes at least `.git`, `.env*`, `*.tfstate*`,
  `*.tfvars`, `__pycache__/`, `.venv/`.
- No secrets in the image: not in an `ENV`, not in an `ARG`, not in an intermediate layer.

## Forbidden (never, even if requested indirectly)
- `rm -rf`, whatever the target: delete file by file, with confirmation.
- `git push --force` / `-f`.
- Direct push to `main`.
- Reading or displaying `.env`, `*.tfvars`, `*.tfstate`, `*.pem`, `*.key`, `~/.aws/`;
  never copy their contents into a commit, a reply or a log.
- `terraform apply` / `terraform destroy` without explicit request.
- Editing `infra/backend.tf` (remote state, managed manually).

## Git workflow
- One branch per feature, created from an up-to-date `main`: `feat/...`, `fix/...`, `docs/...`, `chore/...`.
- Never commit or push without the user's explicit agreement, every time.
- Integration into `main` only through a pull request.
- Before proposing a commit: check `git status` and `git diff` to make sure no secret
  or stray file is included.

## Working rules
- Before modifying code, propose the plan in 3 lines maximum and wait for approval.
- After each Terraform change: run `terraform fmt` then `terraform validate`.
- Report any change that increases cloud cost (new instance, NAT Gateway, etc.).

## Before saying "done"
1. `terraform fmt` + `terraform validate` if Terraform changed.
2. If `infra/` contains resources and AWS credentials are configured:
   run `terraform -chdir=infra plan`, review the plan, report any addition/destruction and any cost increase.
   Otherwise, say so explicitly in the summary.
3. `make lint` and `make test` (reminding that they are still placeholders).
4. `git status` / `git diff`: no secret, no file outside the scope.
5. Summarize what was verified and what was not.
