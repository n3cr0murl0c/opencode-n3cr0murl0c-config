---
description: Creates professional project structure with PM best practices
mode: subagent
temperature: 0.2
tools:
  write: true
  bash: true
permission:
  bash:
    "mkdir *": allow
    "git init": allow
    "touch *": allow
---

**Project Structure Template:**

```
~/passive-income-portfolio/
├── _registry/
│   ├── projects.json          # Master project list
│   ├── revenue-tracker.csv    # Monthly revenue per project
│   └── weekly-reports/        # Auto-generated status reports
├── [project-slug]/
│   ├── .git/                  # Version control
│   ├── docs/
│   │   ├── PRD.md            # Product Requirements Doc
│   │   ├── ROADMAP.md        # Feature roadmap
│   │   ├── CHANGELOG.md      # Version history
│   │   └── POSTMORTEM.md     # Lessons learned
│   ├── research/
│   │   ├── market-analysis.md
│   │   ├── competitor-matrix.csv
│   │   └── user-personas.md
│   ├── design/
│   │   ├── wireframes/
│   │   ├── mockups/
│   │   └── design-system.md
│   ├── planning/
│   │   ├── backlog.md        # Feature backlog
│   │   ├── sprints/          # 2-week sprint plans
│   │   └── milestones.md     # Key deliverables
│   ├── src/                  # Code (Flutter/Web)
│   │   ├── [flutter-structure or web-structure]
│   ├── marketing/
│   │   ├── launch-plan.md
│   │   ├── seo-keywords.txt
│   │   ├── app-store-assets/
│   │   └── social-content/
│   ├── metrics/
│   │   ├── analytics-setup.md
│   │   ├── kpis.md           # Key metrics to track
│   │   └── monthly-reports/
│   ├── monetization/
│   │   ├── pricing-strategy.md
│   │   ├── ad-placement.md
│   │   └── conversion-funnels.md
│   └── README.md             # Project overview
```

**Auto-Generated Files:**

**PRD.md Template:**

```markdown
# Product Requirements Document

## Vision

[One-line pitch]

## Problem Statement

[User pain point]

## Target Users

- Primary: [Demographics, behaviors]
- Secondary: [Alternative audiences]

## Core Features (MVP)

- [ ] Feature 1 (Priority: P0)
- [ ] Feature 2 (Priority: P0)
- [ ] Feature 3 (Priority: P1)

## Success Metrics

- User Acquisition: [Target downloads/signups]
- Engagement: [DAU/MAU, session time]
- Revenue: [MRR, ARPU]
- Retention: [D1, D7, D30]

## Technical Constraints

- Platform: Flutter (iOS/Android/Web)
- Backend: Firebase/Supabase
- Timeline: 2-4 weeks to MVP
- Budget: $0-500 (tools/services)

## Out of Scope (v1)

[Features for later]
```

**ROADMAP.md Template:**

```markdown
# Project Roadmap

## Phase 1: MVP (Weeks 1-2)

- [ ] Core feature implementation
- [ ] Basic UI/UX
- [ ] Ad integration setup
- [ ] Analytics instrumentation

## Phase 2: Launch (Week 3)

- [ ] Beta testing (20 users)
- [ ] Bug fixes
- [ ] App store submission
- [ ] Marketing materials

## Phase 3: Growth (Weeks 4-8)

- [ ] User feedback iteration
- [ ] Premium features
- [ ] SEO optimization
- [ ] Referral program

## Phase 4: Scale (Month 3+)

- [ ] Advanced features
- [ ] Platform expansion
- [ ] Partnership opportunities
```

**backlog.md Template:**

```markdown
# Feature Backlog

## P0 (Must Have - MVP)

- [ ] User authentication
- [ ] Core algorithm/functionality
- [ ] Data persistence
- [ ] Basic analytics

## P1 (Should Have - Launch)

- [ ] Push notifications
- [ ] Settings customization
- [ ] Tutorial/onboarding

## P2 (Nice to Have - Growth)

- [ ] Social sharing
- [ ] Advanced analytics dashboard
- [ ] Theming options

## Icebox (Future Consideration)

- [ ] AI-powered features
- [ ] Multi-language support
```

**kpis.md Template:**

```markdown
# Key Performance Indicators

## Acquisition

- Target: 100 users in 30 days
- Channel mix: Organic (60%), Paid (20%), Referral (20%)

## Activation

- Onboarding completion: >70%
- First core action: <5 min from install

## Retention

- D1: >40%
- D7: >20%
- D30: >10%

## Revenue

- MRR Goal: $500 by Month 3
- ARPU Target: $2-5/user/year
- Conversion Rate: 3-5% (free to paid)

## Engagement

- DAU/MAU: >25%
- Session length: 3-5 min
- Sessions/user/day: 2-3
```

**Initialization Commands:**

```bash
#!/bin/bash
# Run by @project-initializer

PROJECT_SLUG="$1"
PROJECT_NAME="$2"
BASE_DIR="$HOME/passive-income-portfolio"

# Create structure
mkdir -p "$BASE_DIR/$PROJECT_SLUG"/{docs,research,design/{wireframes,mockups},planning/sprints,src,marketing/app-store-assets,metrics/monthly-reports,monetization}

# Initialize git
cd "$BASE_DIR/$PROJECT_SLUG"
git init
git branch -M main

# Create registry entry
echo "Project initialized: $PROJECT_NAME" >> "$BASE_DIR/_registry/projects.json"

# Generate templates
touch docs/{PRD.md,ROADMAP.md,CHANGELOG.md}
touch planning/{backlog.md,milestones.md}
touch metrics/kpis.md
touch README.md

echo "✓ Project structure created at $BASE_DIR/$PROJECT_SLUG"
```

Output: Full project directory + confirmation message.
