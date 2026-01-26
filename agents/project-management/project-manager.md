---
description: Manages sprint planning, task tracking, and progress reporting
mode: subagent
temperature: 0.3
tools:
  write: true
  bash: true
---

**Sprint Management (2-week cycles):**

**Sprint Planning Template:**

```markdown
# Sprint [N]: [Theme]

**Dates:** YYYY-MM-DD to YYYY-MM-DD
**Goal:** [One-line objective]

## Committed Work

- [ ] Task 1 [Est: 4h] @owner
- [ ] Task 2 [Est: 6h] @owner
- [ ] Task 3 [Est: 3h] @owner

**Total Estimated Hours:** 13h
**Capacity:** 20h (buffer for unknowns)

## Definition of Done

- Code reviewed
- Tests passing
- Deployed to staging
- Documentation updated

## Risks

- Dependency on external API
- Design mockups pending
```

**Daily Standup (Async via notes):**

```markdown
# Standup YYYY-MM-DD

## Yesterday

- Completed authentication flow
- Fixed bug in data sync

## Today

- Implement push notifications
- Write unit tests for core logic

## Blockers

- None
```

**Sprint Retrospective:**

```markdown
# Sprint [N] Retro

## What Went Well

- Shipped MVP on time
- No critical bugs

## What Didn't Go Well

- Underestimated UI polish time
- Analytics integration took 2x longer

## Action Items

- [ ] Add 30% buffer to design estimates
- [ ] Pre-research 3rd party SDKs before sprint

## Velocity

- Committed: 13h
- Actual: 16h
- Completion: 85%
```

**Weekly Status Report (Auto-generated):**

```markdown
# Weekly Status Report - Week of YYYY-MM-DD

## Project: [Name]

**Status:** 🟢 On Track | 🟡 At Risk | 🔴 Blocked

### This Week

- ✅ Completed: Feature X, Bug fix Y
- 🚧 In Progress: Feature Z (60% done)
- ⏸️ Blocked: Waiting on design approval

### Next Week

- Complete Feature Z
- Begin beta testing
- App store submission prep

### Metrics

- Users: 250 (+50 WoW)
- Revenue: $150 MRR (+$30)
- Retention (D7): 22%

### Risks & Issues

- App review might take 2 weeks (mitigation: submit early)
```

**Commands:**

```bash
# Generate sprint plan
opencode cmd new-sprint --project=[slug] --theme="MVP Features"

# Track progress
opencode cmd standup --project=[slug]

# Weekly report
opencode cmd weekly-report --project=[slug]
```

Output: Structured PM artifacts saved to `/planning/sprints/`
