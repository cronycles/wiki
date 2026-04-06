# Wiki Repository

This repository is the canonical source for the MediaWiki deployment workflow.

## Root structure
- `docs/`: roadmap, decisions, checklist, and operational notes.
- `mediawiki/`: deployable application code tracked in git.

## Automated deployment
- GitHub Actions workflow: `.github/workflows/deploy.yml`
- cPanel deployment manifest: `.cpanel.yml`
- Server-side deploy script: `scripts/deploy.sh`

The current production path is SSH-based from GitHub Actions to the server.
The previous cPanel UAPI path is not used due to upstream HTTP 415 responses.

### Trigger
- Every push to `main`.
- Manual run via `workflow_dispatch`.

### Deploy verification
After successful deploy, the script writes markers in production web root:
- `/home/crointhe/public_html/w/.deploy-last-commit`
- `/home/crointhe/public_html/w/.deploy-last-ts`

The commit marker must match the commit hash of the workflow run.

## SSH setup for deployment (required)

### GitHub Actions secret
Repository secret required:
- `SSH_PRIVATE_KEY`

Value must be a private key without passphrase that is authorized on server user `crointhe`.

### Current deploy public key
Add this public key to `/home/crointhe/.ssh/authorized_keys` on production:

```text
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEFfweqmZRy5rNR/V72er3QkscmjXS/ETE39PEgGKXfY github-actions-wiki-deploy
```

### Generate/rotate key (developer runbook)
```bash
ssh-keygen -t ed25519 -f ~/.ssh/wiki_deploy_key -N "" -C "github-actions-wiki-deploy"
cat ~/.ssh/wiki_deploy_key.pub
```

Then:
1. Append the `.pub` key to server `~/.ssh/authorized_keys` for `crointhe`.
2. Put private key content from `~/.ssh/wiki_deploy_key` into GitHub secret `SSH_PRIVATE_KEY`.
3. Push to `main` and verify `/home/crointhe/public_html/w/.deploy-last-commit` matches the pushed SHA.

## Manual SSH access

For direct admin access (supporthost key), use:

```bash
ssh -i ~/.ssh/id_rsa_supporthost -p 2299 crointhe@crointhemorning.com
```

### Runtime-safe exclusions
The deploy script excludes and preserves:
- `LocalSettings.php`
- `images/`
- SQLite runtime data outside web root (`/home/crointhe/data`)

## Required GitHub secrets
- `SSH_PRIVATE_KEY`

## Important safety rules
- Do not commit `LocalSettings.php`.
- Do not commit SQLite data files.
- Do not commit runtime uploaded files from `images/`.

## Rollback strategy
- Re-run deployment from the previous known-good commit/tag.
- Keep a validated backup procedure for data and runtime files.
