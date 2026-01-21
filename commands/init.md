Please analyze this codebase and create an AGENTS.md file containing:

1. Build/lint/test commands - especially for running unit test suites and integration test suites.
2. Code style guidelines including imports, formatting, types, naming conventions, error handling, etc.

The file you create will be given to agentic coding agents (such as yourself) that operate in this repository. Make it precise, consice and to the point 150 lines long.
If there are Cursor rules (in .cursor/rules/ or .cursorrules) or Copilot rules (in .github/copilot-instructions.md), or antigravity rules (.agents/rules ) make sure to include them.

The file you create must have a section where it maps general agentic skills and agentic skills specific for the project located in /Users/arcaecuador/Source/Repos/apkAppRecaudacion/.agents/skills/{skill-name}/SKILL.md

# Agent Orchestrator: Repository Analysis & AGENTS.md Generation

You are an expert agent orchestrator specializing in multi-component repository analysis and documentation generation.

## Primary Objective

Analyze the codebase at the project root and generate standardized AGENTS.md files for autonomous coding agents operating within this repository.

## Phase 1: Repository Discovery & Architecture Mapping

### 1.1 Identify Project Type

Analyze the repository structure and determine if the project is:

- [ ] **API-only project** then find backend services, REST/GraphQL endpoints,etc.
- [ ] **Full-stack project** then find integrated frontend + backend, and technologies of the stack.
- [ ] **Dashboard-only project** then find the frontend application stack and its best practices

**Detection Signals:**

- Examine root-level files: `package.json`, `pom.xml`, `requirements.txt`, `Cargo.toml`, `*.csproj`
- Identify framework markers: Next.js, React, Vue, Express, FastAPI, Spring Boot, .NET0,etc.
- Check for `/api`, `/src`, `/client`, `/server`, `/apps`, `/packages`, `/service` directories

### 1.2 Component Discovery

Scan for discrete components/modules:

- Backend APIs
- Web dashboards
- Mobile applications (iOS/Android/React Native)
- SDKs/Libraries
- Microservices
- Shared packages

**Generate output of the project into a structured component map:**

```
Repository: {repo-name}
Architecture: {monorepo|multi-repo|single-app}

Components Detected:
  - Component: {name}
    Type: {API|Dashboard|Mobile|SDK|Service}
    Path: {relative-path}
    Tech Stack: {primary-technologies}
```

### 1.3 External Module Resolution

**Interactive Query to User:**

"I've detected the following components within the project root:

{list detected components}

**Are any project components located in separate directories outside this repository?**

If yes, please provide:

1. Component name (e.g., 'Mobile App', 'Admin Dashboard')
2. Component type (API/Dashboard/Mobile/SDK)
3. Absolute file path
4. Tech stack (if different from main repo)

**Format:**
| Component | Type | Path | Tech Stack |
| --------------- | --------- | ------ | -- |
| mobile-app | Mobile | {path} | React Native |
| admin-dashboard | Dashboard | {path} | Next.js |

Type 'none' if all components are within the current repository."

---

## Phase 2: Standards & Rules Aggregation

### 2.1 Locate Existing Rule Files

Search for and extract content from:

- **Cursor rules**: `.cursor/rules/`, `.cursorrules`
- **Copilot rules**: `.github/copilot-instructions.md`
- **Antigravity rules**: `.agents/rules/`
- **Existing AGENTS.md**: Check if one exists at repository root
- **EditorConfig**: `.editorconfig`
- **Prettier/ESLint**: Configuration files
- **CI/CD configs**: `.github/workflows/`, `.gitlab-ci.yml`, `Jenkinsfile`,`azure-pipelines.yml`,`docker-compose.yml`,etc.

### 2.2 Skills Mapping

Catalog skills from:

```
{project_root}/.agents/skills/{skill-name}/SKILL.md
```

**Create two-tier skill inventory:**

1. **General agentic skills** (applicable to any project)
   - Code review, refactoring, testing, documentation
2. **Project-specific skills** (domain/tech-specific)
   - Custom workflows, business logic patterns, domain rules

---

## Phase 3: AGENTS.md Generation

### 3.1 File Structure Template

```markdown
# AGENTS.md - {Component Name}

## Quick Reference

- **Component Type**: {API|Dashboard|Mobile|SDK}
- **Tech Stack**: {languages, frameworks, tools}
- **Last Updated**: {YYYY-MM-DD}

## 1. Build, Lint & Test Commands

### Build

\`\`\`bash
{build command}
\`\`\`

### Lint

\`\`\`bash
{lint command}
\`\`\`

### Test Suites

- **Unit Tests**: \`{unit test command}\`
- **Integration Tests**: \`{integration test command}\`
- **E2E Tests**: \`{e2e test command}\` (if applicable)

## 2. Code Style Guidelines

### Import Organization

{import ordering rules, path aliases}

### Formatting

- **Indentation**: {spaces/tabs}
- **Line Length**: {max characters}
- **Quotes**: {single|double}
- **Semicolons**: {required|optional}

### Type System

{TypeScript/Flow/PropTypes/JSDoc requirements}

### Naming Conventions

- **Files**: {kebab-case|camelCase|PascalCase}
- **Variables**: {conventions}
- **Functions**: {conventions}
- **Classes**: {conventions}
- **Constants**: {UPPER_SNAKE_CASE|etc}

### Error Handling

{try-catch patterns, error boundaries, logging standards}

## 3. Architecture Patterns

{component structure, state management, data flow}

## 4. Skills Available

### General Agentic Skills

{list from /.agents/skills/ - general purpose}

### Project-Specific Skills

{list from /.agents/skills/ - domain specific}

## 5. Inherited Rules

{content from .cursor/rules, .github/copilot-instructions.md, .agents/rules}

## 6. Component Dependencies

{list other components this module depends on}
```

### 3.2 Generation Requirements

**Constraints:**

- **Length**: 100-200 lines (concise, scannable)
- **Tone**: Imperative, directive (commands for agents)
- **Format**: Markdown with clear hierarchies
- **Examples**: Include 2-3 code snippets for critical patterns
- **No fluff**: Every line must be actionable

**Quality Checks:**

- [ ] All test commands are executable
- [ ] Style rules are specific, not vague
- [ ] Skills are properly categorized
- [ ] Component boundaries are clear
- [ ] Cross-references to other AGENTS.md files work

---

## Phase 4: Multi-Component Orchestration

### 4.1 Component-Specific File Placement

Generate individual AGENTS.md files per component:

| Component     | File Location              | Scope                      |
| ------------- | -------------------------- | -------------------------- |
| SDK           | `/sdk/AGENTS.md`           | SDK development rules      |
| API           | `/api/AGENTS.md`           | Backend service patterns   |
| Mobile App    | `/mobile-app/AGENTS.md`    | Mobile-specific guidelines |
| Web Dashboard | `/web-dashboard/AGENTS.md` | Frontend framework rules   |

### 4.2 Root Orchestrator

Create `/AGENTS.md` (root) as master index:

```markdown
# Repository Agent Orchestration

## Component Registry

- [SDK](./sdk/AGENTS.md)
- [API](./api/AGENTS.md)
- [{SERVICE_APP}](./{SERVICE_APP}/AGENTS.md)
- [Mobile App](./mobile-app/AGENTS.md)
- [Web Dashboard](./web-dashboard/AGENTS.md)

## Cross-Component Guidelines

{shared standards across all components}
```

---

## Phase 5: Documentation

### 5.1 Initialize Documentation

modifiy or create `{project_root}/README.md` (root) as Docs master index and repository summary and summary of the core business processes handled by the application, whatever you can add to create value to user reading the project for the first time, like a high-level overview, business process summary, and execution workflow.

```markdown
# {Project Name}

## Repository Summary

- [AGENTS.md](./AGENTS.md)
- [Changelog](./CHANGELOG.md)
- [Contributing](./CONTRIBUTING.md)
- [License](./LICENSE)

## Business Process Summary

- {Business Process 1}
- {Business Process 2}
- {Business Process 3}
  ...
```

## Execution Workflow

1. **Analyze** → Read repository structure
2. **Question** → Ask user about external components
3. **Aggregate** → Collect all rules, configs, skills
4. **Generate** → Create AGENTS.md file(s) and README.md file(s)
5. **Validate** → Test that commands work
6. **Update** → If AGENTS.md exists at root, merge improvements

**If existing AGENTS.md found:**

- Preserve user customizations
- Enhance with missing sections
- Update outdated commands
- Add version changelog at bottom

---

## Output Format

Present results as:

1. **Architecture Summary** (discovered structure)
2. **Generated Files** (list of AGENTS.md locations)
3. **Validation Report** (command test results)
4. **Next Steps** (recommendations for agents using these files)

Begin analysis now.
