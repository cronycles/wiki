# Execution Checklist - Repo Canonical + Auto Deploy

## 1. Baseline Validation
- [x] Confirm MediaWiki version in production (`1.41.0`).
- [x] Confirm DB engine (`SQLite`).
- [x] Confirm production app path (`/home/crointhe/public_html/w`).
- [x] Identify SQLite directory (`/home/crointhe/data`).

## 2. Backup and Recovery
- [x] Create production backup bundle (config + images + extensions + skins + sqlite data).
- [x] Generate SHA256 checksums for backup artifacts.
- [x] Copy backup to local machine.
- [x] Verify checksum integrity locally.
- [x] Extract backup locally and verify restore readability.
- [ ] Document rollback commands for code-only deploy failure.

## 3. Repository Hygiene
- [ ] Ensure runtime artifacts are ignored by git (backup folders, extracted data, cache-like files).
- [ ] Decide whether full `extensions/` is tracked or partially managed.
- [ ] Ensure secrets are not committed (`LocalSettings.php` strategy).
- [ ] Define release tagging convention.

## 4. Deploy Strategy Definition
- [ ] Define deploy trigger: push to `main`.
- [ ] Define transport: SSH on port `2299`.
- [ ] Define deploy destination: `/home/crointhe/public_html/w`.
- [ ] Define non-overwrite/non-delete exclusions for `images/`, `LocalSettings.php`, and `/home/crointhe/data`.
- [ ] Define post-deploy smoke checks (`Special:Version`, page edit, save, render).

## 5. CI/CD Implementation
- [ ] Add deploy workflow file in repository (GitHub Actions or equivalent).
- [ ] Add required repository secrets (SSH key, host, user, port).
- [ ] Add dry-run deploy mode for staging/test.
- [ ] Add failure notifications and rollback instruction output.

## 6. Staging and Production Validation
- [ ] Validate full deploy flow in staging path/server.
- [ ] Validate editor UX (toolbar and visual editing if enabled).
- [ ] Validate templates/transclusions, uploads, and search.
- [ ] Promote same workflow to production.

## 7. Operational Routine
- [ ] Enforce "no direct manual edits in production" policy (except emergency).
- [ ] Schedule periodic backup verification drills.
- [ ] Keep docs aligned after every deployment architecture change.
