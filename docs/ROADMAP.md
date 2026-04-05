# Roadmap - MediaWiki Source-of-Truth + Auto Deploy

## Objective
Make this repository the official source of MediaWiki application code and deploy automatically to production path `/home/crointhe/public_html/w` while keeping runtime data safe.

## Current Baseline (validated)
- MediaWiki version: `1.41.0`.
- DB engine: `SQLite`.
- Main DB path: `/home/crointhe/data/crointhe_wiki.sqlite`.
- Production app path: `/home/crointhe/public_html/w`.
- Production host access: SSH available.
- Production backup copied and validated with SHA256 in local workspace.

## Deployment Model
1. `main` branch is canonical source for production code.
2. CI/CD deploys code to `/home/crointhe/public_html/w` on push to `main`.
3. Runtime data is never overwritten by deploy:
	- `/home/crointhe/data/*` (SQLite files)
	- `/home/crointhe/public_html/w/images/*`
	- `/home/crointhe/public_html/w/LocalSettings.php`
4. Every production deploy has a rollback package and rollback command.

## Phases

### Phase 0 - Repository Hardening (now)
- Define what is tracked vs excluded in git.
- Keep backup artifacts out of tracked source history.
- Document production-safe deploy exclusions.

Deliverable: repository policy and guardrails.

### Phase 1 - Deployment Pipeline Design
- Define deploy transport (SSH + rsync/scp strategy).
- Define atomic or near-atomic release flow.
- Define pre-deploy and post-deploy checks.

Deliverable: documented deploy workflow with rollback.

### Phase 2 - Staging First
- Deploy from this repo to staging path/server.
- Validate edit flows (WikiEditor/VisualEditor), rendering, uploads.
- Validate maintenance scripts in staging.

Deliverable: staging sign-off.

### Phase 3 - Production Automation
- Enable deploy on push to `main`.
- Preserve runtime data and local environment settings.
- Run smoke tests immediately after deploy.

Deliverable: production auto-deploy active.

### Phase 4 - Operations Stability
- Add release tagging and change log discipline.
- Add periodic backup verification and restore drills.
- Monitor for extension compatibility regressions.

Deliverable: repeatable and low-risk operations.

## Success Metrics
- 0 data loss incidents.
- Deploy to production is reproducible from `main`.
- Rollback can be completed quickly with documented steps.
- Editing UX remains modern (toolbar/visual editing available).

## Out of Scope (for now)
- Platform migration away from MediaWiki.
- UI redesign unrelated to editing workflow.
- Data model refactors or content restructuring.
