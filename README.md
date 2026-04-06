# Wiki Repository

This repository is the canonical source for the MediaWiki deployment workflow.
<!-- deploy-test: 2026-04-06 -->

## Root structure
- `docs/`: roadmap, decisions, checklist, and operational notes.
- `mediawiki/`: deployable application code tracked in git.

## Automated deployment (cPanel)
- GitHub Actions workflow: `.github/workflows/deploy.yml`
- cPanel deployment manifest: `.cpanel.yml`
- Server-side deploy script: `scripts/deploy.sh`

### Trigger
- Every push to `main`.
- Manual run via `workflow_dispatch`.

### Deploy verification
After successful deploy, the script writes markers in production web root:
- `/home/crointhe/public_html/w/.deploy-last-commit`
- `/home/crointhe/public_html/w/.deploy-last-ts`

The commit marker must match the commit hash of the workflow run.

### Runtime-safe exclusions
The deploy script excludes and preserves:
- `LocalSettings.php`
- `images/`
- SQLite runtime data outside web root (`/home/crointhe/data`)

## Required GitHub secrets
- `CPANEL_USER`
- `CPANEL_TOKEN`
- Optional: `CPANEL_HOST` (default `crointhemorning.com`)
- Optional: `CPANEL_REPOSITORY_ROOT` (default `/home/crointhe/repositories/wiki`)

## Important safety rules
- Do not commit `LocalSettings.php`.
- Do not commit SQLite data files.
- Do not commit runtime uploaded files from `images/`.

## Rollback strategy
- Re-run deployment from the previous known-good commit/tag.
- Keep a validated backup procedure for data and runtime files.
