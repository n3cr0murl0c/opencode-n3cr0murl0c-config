---
name: project-docs
description: >
  project documentation style guide and writing standards.
Trigger: When writing documentation for project features, tutorials, or guides.
license: Apache-2.0
metadata:
  author: Erick Escobar
  version: "1.0"
  scope: [root]
  auto_invoke: "Writing documentation"
allowed-tools: Read, Edit, Write, Glob, Grep, Bash, WebFetch, WebSearch, Task
---

## When to Use

Use this skill when writing project documentation for:

- Feature documentation
- API/SDK references
- Tutorials and guides
- Release notes
- Technical Documentation

## Brand Voice

### Unbiased Communication

- Avoid gendered pronouns (use "you/your" or "they/them")
- Use inclusive alternatives: businessman → businessperson, mankind → humanity
- No generalizations about gender, race, nationality, culture
- Avoid militaristic language: fight → address, kill chain → cyberattack chain

### Technical Terminology

- Define key terms and acronyms on first use: "Identity and Access Management (IAM)"
- Prefer verbal over nominal constructions: "The report was created" not "The creation of the report"
- Use clear, accessible language; minimize jargon

## Formatting Standards

### Title Case Capitalization

Use Title Case for all headers:

- Good: "How to Configure Security Scanning"
- Bad: "How to configure security scanning"

### Hyphenation

- Prenominal position: "world-leading company"
- Postnominal position: "features built in"

### Bullet Points

Use when information can be logically divided:

```markdown
project CLI includes:

- **Industry standards:** CIS, NIST 800, NIST CSF
- **Regulatory compliance:** RBI, FedRAMP, PCI-DSS
- **Privacy frameworks:** GDPR, HIPAA, FFIEC
```

### Interaction Verbs

- Desktop: Click, Double-click, Right-click, Drag, Scroll
- Touch: Tap, Double-tap, Press and hold, Swipe, Pinch

## SEO Optimization

### Sentence Structure

Place keywords at the beginning:

- Good: "To create a custom role, open a terminal..."
- Bad: "Open a terminal to create a custom role..."

### Headers

- H1: Primary (unique, descriptive)
- H2-H6: Subheadings (logical hierarchy)
- Include keywords naturally

## MDX Components

### Version Badge

```mdx
import { VersionBadge } from "/snippets/version-badge.mdx";

## New Feature Name

<VersionBadge version="4.5.0" />

Description of the feature...
```

### Warnings and Danger Calls

```mdx
<Warning>
  Disabling encryption may expose sensitive data to unauthorized access.
</Warning>

<Danger>Running this command will **permanently delete all data**.</Danger>
```

## project Features (Proper Nouns)

Reference without articles:

- project App, project CLI, project SDK
- project Cloud, project Studio, project Registry
- Built-in Compliance Checks
- Multi-cloud Security Scanning
- Autonomous Cloud Security Analyst (AI)

## Documentation Structure

```
docs/
├── getting-started/
├── tutorials/
├── providers/
│   ├── aws/
│   ├── azure/
│   ├── gcp/
│   └── ...
├── api/
├── sdk/
├── compliance/
└── developer-guide/
```

## Internationalization

- English
- Spanish (Español) - Latin America Transalte the docs generated in english to Spanish

## Resources

- **Documentation**: See [references/](references/) for links to local developer guide
