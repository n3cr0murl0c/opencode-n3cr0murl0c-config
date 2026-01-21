---
name: project-commits
description: >
  Creates a Commits for project following the project template and conventions.
trigger: When working on commit creation on git repository be as it may github or azuredevops.
license: Apache-2.0
metadata:
  author: Erick Escobar
  version: "1.0"
  scope: [root]
  auto_invoke:
    - "Create a commit "
    - "Fill .github/pull_request_template.md (Context/Description/Steps to review/Checklist)"
    - "Inspect PR CI workflows (.github/workflows/*): conventional-commit, pr-check-changelog, pr-conflict-checker, labeler"
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, WebFetch, WebSearch, Task
---

#### SDK/CLI

- Are there new checks included in this PR? Yes / No
  - If so, do we need to update permissions for the provider? Please review this carefully.

#### UI (if applicable)

- [ ] All issue/task requirements work as expected on the UI
- [ ] Screenshots/Video - Mobile (X < 640px)
- [ ] Screenshots/Video - Tablet (640px > X < 1024px)
- [ ] Screenshots/Video - Desktop (X > 1024px)
- [ ] Ensure new entries are added to ui/CHANGELOG.md

#### API (if applicable)

- [ ] All issue/task requirements work as expected on the API
- [ ] Endpoint response output (if applicable)
- [ ] EXPLAIN ANALYZE output for new/modified queries or indexes (if applicable)
- [ ] Performance test results (if applicable)
- [ ] Any other relevant evidence of the implementation (if applicable)
- [ ] Verify if API specs need to be regenerated.
- [ ] Check if version updates are required.
- [ ] Ensure new entries are added to api/CHANGELOG.md

## Component-Specific Rules

| Component | CHANGELOG                 | Extra Checks                                                           |
| --------- | ------------------------- | ---------------------------------------------------------------------- |
| SDK       | `project/CHANGELOG.md`    | New checks → permissions update?                                       |
| API       | `api/CHANGELOG.md`        | API specs, version bump, endpoint output, EXPLAIN ANALYZE, performance |
| UI        | `ui/CHANGELOG.md`         | Screenshots for Mobile/Tablet/Desktop                                  |
| MCP       | `mcp_server/CHANGELOG.md` | N/A                                                                    |

## Formato

<type>(scope): <description>

## Types

- feat: A new feature
- fix: A bug fix -> relacionar el codigo de INC
- docs: Documentation only changes
- style: Changes that do not affect the meaning of the code (white-space, formatting, missing semi-colons, etc)
- refactor: A code change that neither fixes a bug nor adds a feature
- perf: A code change that improves performance
- test: Adding missing tests or correcting existing tests
- build: Changes that affect the build system or external dependencies (example scopes: gulp, broccoli, npm)
- chore: Other changes that are not relevant to the main functionality of the codebase.

## Example

feat: added new feature that does this and that .

fix: fixed bug located at with RCA#1234.

## Before Creating PR

1. ✅ All tests pass locally
2. ✅ Linting passes (`make lint` or component-specific)
3. ✅ CHANGELOG updated (if applicable)
4. ✅ Branch is up to date with main
5. ✅ Commits are clean and descriptive
