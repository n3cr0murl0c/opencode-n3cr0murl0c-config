---
description: Analyzes portfolio performance and recommends optimizations
mode: subagent
temperature: 0.3
tools:
  write: true
  bash: true
---

**Portfolio Dashboard:**

```markdown
# Passive Income Portfolio Status

**Last Updated:** YYYY-MM-DD

## Active Projects (5)

| Project            | Status   | MRR    | Users | ROI  | Priority |
| ------------------ | -------- | ------ | ----- | ---- | -------- |
| Habit Tracker Pro  | Live     | $1,200 | 2,500 | 240% | High     |
| Expense Calculator | Live     | $300   | 800   | 60%  | Medium   |
| Pomodoro Focus     | Beta     | $50    | 150   | -20% | Low      |
| Recipe Optimizer   | Planning | $0     | 0     | -    | High     |
| Fitness Logger     | Paused   | $0     | 0     | -    | Low      |

**Total MRR:** $1,550
**Total Monthly Hours:** 15h (maintenance + growth)
**Effective Hourly Rate:** $103/hr

## Recommendations

### 🚀 Scale

- **Habit Tracker Pro:** Invest in paid ads ($200/mo), projected +$500 MRR
- **Recipe Optimizer:** Fast-track to launch (high market demand)

### ⏸️ Pause

- **Fitness Logger:** Saturated market, low differentiation

### 🔧 Optimize

- **Expense Calculator:** Improve conversion funnel (currently 2%, target 5%)

### 📊 Metrics to Watch

- Habit Tracker D30 retention dropped 5% → investigate onboarding
- Pomodoro Focus install rate stagnant → revisit ASO strategy
```

**Monthly Portfolio Review:**

```bash
# Generate report
@portfolio-analyst create monthly-review

# Outputs:
# - Performance comparison (MoM growth)
# - Project health scores
# - Resource allocation recommendations
# - New opportunity identification
```

Save to: `~/passive-income-portfolio/_registry/monthly-reviews/YYYY-MM.md`

```

---

## Usage Workflow

### 1. Generate New Idea
```

@income-strategist I need a new passive income project.
Focus on productivity tools, moderate effort, Flutter + web.
Target: $500/month within 3 months.

```

**Output:**
- 3 validated ideas with market analysis
- Revenue projections
- Recommended idea with reasoning

---

### 2. Initialize Project
```

@income-strategist Let's move forward with "AI Meeting Notes Summarizer".
Initialize the full project structure.

```

**Creates:**
```

~/passive-income-portfolio/ai-meeting-notes/
├── docs/PRD.md (filled with idea details)
├── research/market-analysis.md
├── planning/backlog.md (prioritized features)
├── monetization/revenue-projections.md
├── .git/ (initialized)
└── README.md

```

---

### 3. Sprint Planning
```

@income-strategist Create Sprint 1 plan for ai-meeting-notes.
Focus: MVP core features (record, transcribe, summarize).
