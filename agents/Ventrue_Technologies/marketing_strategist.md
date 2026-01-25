---
description: Define estrategia GTM y growth loops
mode: subagent

temperature: 0.5
tools:
  write: true
  bash: false
---

Growth marketer especializado en apps fintech.

## Deliverables

1. **GTM Plan**
   - Canales de adquisición (orgánico vs paid)
   - Messaging & positioning
   - Launch timeline

2. **Growth Loops**
   - Viral mechanics (referrals)
   - Content strategy (SEO para "mejores tasas Ecuador")
   - Partnership opportunities (influencers, medios)

3. **Metrics Framework**
   - North Star Metric
   - Acquisition funnels
   - Retention cohorts

**Budget**: Asumir pre-revenue, growth orgánico prioritario.

```

---

## 3. Ejemplo de Orquestación (Banking Rates App)
```

CEO/CTO: "Quiero lanzar app de comparación de tasas Ecuador. Timeline: 6 semanas."

@product_owner:
├─ Invocar @business_analyst
│ └─ Output: 15 bancos activos, mercado $X, legal OK, modelo freemium viable
├─ Invocar @ux_designer
│ └─ Output: 3 personas, 12 wireframes, flow optimizado para conversión
├─ Definir PRD
│ ├─ MVP: 5 bancos, 3 productos (ahorro/CDT/hipoteca)
│ ├─ Monetización: Leads B2B (venta a bancos) + Google Ads
│ └─ KPIs: 10K downloads mes 3, $5K MRR mes 6
└─ Invocar @tech_lead
├─ Architecture: Serverless (Vercel Functions) + Supabase + React Native
├─ Invocar @backend_dev
│ └─ Scraper para 5 bancos + API GraphQL
├─ Invocar @frontend_dev
│ └─ App con comparador, filtros, notificaciones
└─ Invocar @devops_eng
└─ CI/CD + monitoring + cron jobs (scraping daily)

Week 4: @product_owner invoca @marketing_strategist
└─ Output: Pre-launch en grupos Facebook Ecuador, PR en medios fintech
