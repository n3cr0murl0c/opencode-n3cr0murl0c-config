---
description: analyzes repository and generates AGENTS.md documentation with component-specific guidelines
agent: agent_orchestrator_primary_agent
subtask: false
temperature: 0.2
---

# Repository Analysis & AGENTS.md Generation

Analyze this codebase and orchestrate the generation of comprehensive AGENTS.md documentation files.

## Your Mission

Execute the complete repository analysis workflow:

### Phase 1: Repository Discovery & Architecture Mapping

1. **Identify Project Type**:
   - Scan for project files: `package.json`, `*.csproj`, `pubspec.yaml`, `requirements.txt`, `pom.xml`, `Cargo.toml`
   - Determine if this is: API-only, Full-stack, Dashboard-only, Microservices, Monorepo
   - Detect frameworks: .NET (8/9/10), Next.js, React, Vue, Flutter, Express, FastAPI, Spring Boot

2. **Component Discovery**:
   - Scan for discrete components in: `/api`, `/src`, `/client`, `/server`, `/apps`, `/packages`, `/services`, `/web`, `/mobile`, `/sdk`
   - Generate structured component map showing: Name, Type, Path, Tech Stack

3. **External Module Resolution**:
   - After discovery, ask user: "Are any project components located outside this repository?"
   - If yes, request: Component name, Type, Absolute path, Tech stack
   - Format response as table

### Phase 2: Standards & Rules Aggregation

**Locate and extract content from**:

- Cursor rules: `.cursor/rules/`, `.cursorrules`
- Copilot rules: `.github/copilot-instructions.md`
- Antigravity rules: `.agents/rules/`
- EditorConfig: `.editorconfig`
- Linters: `.eslintrc*`, `prettier.config.*`, `.prettierrc*`
- CI/CD: `.github/workflows/`, `.gitlab-ci.yml`, `azure-pipelines.yml`, `docker-compose.yml`
- Existing AGENTS.md files (if present)

**Skills Mapping**:

- Scan: `$PROJECT_ROOT/.agents/skills/{skill-name}/SKILL.md`
- Categorize into:
  - General agentic skills (code-review, testing, refactoring)
  - Project-specific skills (domain logic, custom workflows)

### Phase 3: Invoke Specialized Subagent

Delegate the actual AGENTS.md generation to:

```
@repo-analyzer
```

Provide the subagent with:

- Component architecture map
- Extracted rules and standards
- Skills inventory
- Detected tech stacks
- Build/test/lint commands discovered

### Phase 4: Component-Specific Reviews (if needed)

Based on components detected, invoke appropriate reviewers:

- `.NET API` → `@net-api-reviewer`
- `Frontend (React/Vue/Angular)` → `@frontend-reviewer`
- `Flutter Mobile` → `@flutter-mobile-handler`
- `Console Apps` → `@console-app-handler`

### Phase 5: Documentation Synthesis

Ensure the following are generated/updated:

**Per-Component AGENTS.md** (100-200 lines each):

- `/api/AGENTS.md`
- `/web/AGENTS.md`
- `/mobile/AGENTS.md`
- `/{component}/AGENTS.md`

**Root Files**:

- `/AGENTS.md` - Master orchestrator with component registry
- `/README.md` - Enhanced with business process overview

**README.md Requirements**:

- High-level project overview
- Business processes handled by application
- Component architecture summary
- Quick start commands
- Documentation links

## Expected Output

Present results as:

1. **Architecture Summary**:

```
   Repository: {name}
   Type: {architecture-type}

   Components:
   - {component} [{type}] @ {path} → {stack}
```

2. **Generated Files**:
   - List all created/updated AGENTS.md locations
   - List README.md updates

3. **Validation Report**:
   - Test that build/lint/test commands execute
   - Verify file paths are correct
   - Confirm cross-references work

4. **Skills Available**:
   - General: {list}
   - Project-specific: {list}

5. **Next Steps**:
   - Recommendations for agents using these files
   - Suggested workflow improvements

## Quality Requirements

- All commands must be executable (validate with bash)
- AGENTS.md files: 100-200 lines, concise, scannable
- Style rules must be specific, not vague
- Include 2-3 code examples for critical patterns
- Every line must be actionable (no fluff)
- If AGENTS.md exists, preserve customizations and merge improvements

## Execution Flow

1. Analyze repository structure
2. Query user about external components
3. Extract all rules, configs, skills
4. Invoke `@repo-analyzer` for file generation
5. Invoke component reviewers as needed
6. Validate generated files
7. Present comprehensive report

Begin analysis now.
