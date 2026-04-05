# AGENTS - Working Agreement for This Repo

## Default Agent Behavior
- Prioritize data safety and rollback readiness.
- Prefer incremental changes over big-bang migrations.
- Always separate discovery, implementation, and validation.

## Standard Task Template
For any technical task, return:
1. Assumptions.
2. Exact steps/commands.
3. Validation checks.
4. Rollback steps.

## Risk Flags (must be called out early)
- DB schema changes.
- Extension replacement/removal.
- Authentication or permission behavior changes.
- URL/permalink changes.

## Definition of Done (upgrade tasks)
- Staging run completed.
- Backup + restore tested.
- Editor UX validated (toolbar actions work).
- No critical regression on key pages.
