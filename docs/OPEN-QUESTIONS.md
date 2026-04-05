# Open Questions - Canonical Repo and Auto Deploy

## Already Answered
- MediaWiki version: `1.41.0`.
- DB engine: `SQLite`.
- DB path family: `/home/crointhe/data/*.sqlite`.
- Production code path: `/home/crointhe/public_html/w`.
- Backup + checksum + local restore verification: completed.

## Deployment Governance
- Do we enforce required PR reviews before merge to `main`?
- Should deploy run on every `main` push or only on version tags?
- Should production deploy require manual approval in CI?

## CI/CD Technical Details
- Which CI runner will execute deployment (GitHub-hosted vs self-hosted)?
- Which SSH key will be dedicated to deploy automation?
- Is `rsync` available in CI runner and target host, or should workflow use `scp` + remote unpack?

## Files and Secrets Policy
- Should `LocalSettings.php` be fully unmanaged in git, or replaced with `LocalSettings.php.template`?
- Which files in `extensions/` are custom and must be pinned?
- Should user-uploaded `images/` be backed up independently from code deploy cadence?

## Staging and Rollback
- What is the staging target path/server for pre-production validation?
- What is the maximum acceptable production downtime for rollback?
- Do we need one-click rollback to previous release artifact?

## Editor UX Scope
- Keep WikiEditor toolbar only, or enforce VisualEditor as default for all users?
- Which namespaces should explicitly allow visual editing?
