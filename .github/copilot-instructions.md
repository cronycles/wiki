# Copilot Instructions - Wiki Modernization

## Project Context
- Repository purpose: modernize a legacy personal wiki currently running at http://www.crointhemorning.com/w/
- Priority: keep existing content and database data intact
- Main pain point: editing UX is too basic (manual wiki tags, no rich toolbar)

## High-Level Goal
Deliver a safer upgrade path that introduces a modern editing experience with minimal content risk.

## Preferred Technical Direction
- Default path: upgrade MediaWiki to a supported LTS version and enable VisualEditor + Parsoid.
- Migration to a different platform is allowed only after a data portability and feature parity check.

## Constraints
- Data integrity first: schema/content preservation beats speed.
- Every risky step must include rollback notes.
- Test in staging before touching production.
- Avoid destructive DB operations without explicit approval.

## Expected Outputs For Tasks
When asked to implement or plan changes, produce:
1. A clear step-by-step execution plan.
2. Required config/code changes with file-level detail.
3. Validation checks (what to test and expected result).
4. Rollback instructions.

## Documentation Rule
If architecture or migration choices change, update files in docs/:
- docs/ROADMAP.md
- docs/DECISIONS.md
- docs/CHECKLIST.md

## Communication Style
- Keep explanations practical and action-oriented.
- Highlight risks early (version compatibility, extension compatibility, data migration edge cases).
- Prefer small safe iterations.
