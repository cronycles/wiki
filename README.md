# Wiki Repository

This repository is the canonical source for the MediaWiki deployment workflow.

## Root structure
- `docs/`: roadmap, decisions, checklist, and operational notes.
- `mediawiki/`: deployable application code tracked in git.

## Automated deployment (cPanel)
- GitHub Actions workflow: `.github/workflows/deploy.yml`
- cPanel deployment manifest: `.cpanel.yml`
- Server-side deploy script: `scripts/deploy.sh`

### Trigger
- Push to `main` touching `mediawiki/**`, `scripts/deploy.sh`, `.cpanel.yml`, or workflow file.
- Manual run via `workflow_dispatch`.

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
