# Architecture Decisions - Wiki Modernization

## Decision 001 - Keep MediaWiki as primary platform
Status: Accepted

### Context
The production wiki already runs on MediaWiki `1.41.0` and data integrity is the main priority.

### Decision
Keep MediaWiki as the long-term platform and optimize editing UX with built-in/compatible editor extensions.

### Why
- Lowest risk for content, history, templates, and URLs.
- No forced migration of existing data model.
- Faster path to better editing UX.

### Risks
- Extension compatibility drift over time.
- Editor behavior differences on complex templates.

### Mitigations
- Staging validation before production.
- Pin extension versions in repository.
- Keep rollback artifacts for every deploy.

## Decision 002 - Repository is production source of truth
Status: Accepted

### Decision
This repository is the canonical source for production application code. Pushes to `main` are eligible for automatic deployment to `/home/crointhe/public_html/w`.

### Why
- Single controlled source for changes.
- Repeatable releases and easier audit trail.
- Lower operational drift between local and production code.

### Risks
- Accidental deployment of non-production artifacts.
- Human error in direct production edits outside git.

### Mitigations
- Use branch protections and required checks.
- Ignore backup/runtime artifacts in git.
- Treat production filesystem edits as emergency-only, then back-port to git.

## Decision 003 - Runtime data remains outside deploy payload
Status: Accepted

### Decision
Deployment must never overwrite or delete runtime data and environment-specific files.

### Protected paths/files
- `/home/crointhe/data/*` (SQLite databases and lock files).
- `/home/crointhe/public_html/w/images/*` (uploaded media).
- `/home/crointhe/public_html/w/LocalSettings.php` (environment secrets/config).

### Why
- Prevent irreversible data loss.
- Keep secrets out of source control.
- Preserve uploads and live runtime state.

### Mitigations
- Enforce deploy exclusions.
- Maintain pre-deploy backup step.
- Verify protected paths are unchanged after deploy.

## Decision 004 - Migration to another wiki platform is deferred
Status: Accepted

### Decision
No migration to Wiki.js/BookStack unless MediaWiki path becomes unsustainable.

### Trigger conditions
- Unresolvable compatibility constraints in required features.
- Repeated production instability despite controlled upgrades.
- Operational burden remains high after stabilization.

### Required evidence before reconsidering migration
- Real export/import test with representative pages and templates.
- Permission/auth mapping plan.
- URL continuity and redirect plan.
