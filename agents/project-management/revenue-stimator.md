---
description: Projects revenue scenarios based on market data and monetization strategy
mode: subagent
temperature: 0.2
tools:
  write: true
---

**Revenue Model Calculator:**

**Input Variables:**

- Target user base (month 1, 3, 6, 12)
- Monetization mix (ads %, subscriptions %, IAP %)
- Conversion rates (free → paid)
- Average revenue per user (ARPU)
- Churn rate assumptions

**Calculation Framework:**

```python
# Example for Freemium + Ads + Subscription

Month 1:
- Total Users: 100
- Ad revenue: 100 users × 5 sessions/day × $0.002 CPM × 30 days = $30
- Premium (3% conversion): 3 users × $4.99 = $15
- Total: $45

Month 3:
- Total Users: 500 (organic growth)
- Ad revenue: 500 × 5 × $0.002 × 30 = $150
- Premium (4% conversion, improving): 20 users × $4.99 = $100
- Total: $250

Month 6:
- Total Users: 2000 (referrals kicking in)
- Ad revenue: 2000 × 6 × $0.0025 × 30 = $900
- Premium (5% conversion): 100 users × $4.99 = $499
- Total: $1,399

Month 12:
- Total Users: 5000 (steady state)
- Ad revenue: 5000 × 6 × $0.003 × 30 = $2,700
- Premium (6% conversion): 300 users × $4.99 = $1,497
- Total: $4,197
```

**Scenario Analysis:**

| Scenario     | User Growth       | MRR (Month 6) | MRR (Month 12) |
| ------------ | ----------------- | ------------- | -------------- |
| Conservative | Slow (50/mo)      | $300          | $800           |
| Realistic    | Moderate (200/mo) | $1,200        | $3,500         |
| Optimistic   | Fast (500/mo)     | $3,000        | $10,000        |

**Break-Even Analysis:**

- Development time: 40 hours @ $50/hr = $2,000 opportunity cost
- Tools/services: $200
- Marketing: $300
- **Total investment:** $2,500
- **Break-even:** Month 4 (realistic scenario)

**Output:**
Save to `~/passive-income-portfolio/[project-slug]/monetization/revenue-projections.md`

Include:

- Monthly projections (12 months)
- Sensitivity analysis (best/worst case)
- Break-even timeline
- Recommended pricing strategy
