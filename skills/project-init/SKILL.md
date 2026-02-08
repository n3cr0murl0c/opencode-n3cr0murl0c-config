---
name: project-init
description: >
  Initializes OpenCode agent workspace in project root, fetching skills from ~/.conf/opencode.
  Trigger: When starting work on a new project, setting up agent infrastructure, or user asks to "init project" or "setup agents".
license: Apache-2.0
metadata:
  author: n3cr0murl0c
  version: "1.1"
  scope: [root]
  auto_invoke: "Project initialization"
allowed-tools: Read, Write, Glob, Bash
---

## When to Use

- First time working on a project (always run in project root)
- User asks to "init project", "setup agents", or "check opencode"
- After cloning a new repository
- Before creating project-specific skills

**CRITICAL**: Always invoke from project root directory.

## Critical Patterns

### OpenCode Configuration

```
~/.conf/opencode/           # Central configuration
├── skills/                 # Global skills library
│   ├── skill-creator/
│   ├── project-init/
│   └── ...
├── commands/               # Global command aliases
├── rules/                  # Global coding rules
└── templates/              # Project templates
```

### Project Structure After Init

```
/{project-root}/
├── AGENTS.md              # Required - skill registry
└── ...                    # Project files
```

### Validation Checks

| Check                       | Required | Action if Missing             |
| --------------------------- | -------- | ----------------------------- |
| `~/.conf/opencode/`         | Yes      | Error: OpenCode not installed |
| `AGENTS.md` in project root | Yes      | Create from template          |

### AGENTS.md Template

```markdown
# AI Agent Skills

OpenCode-enabled project. Skills loaded from `~/.conf/opencode/skills/` and `.opencode/skills/`.

## Global Skills Available (~/.conf/opencode/skills/ update if found more skills)

| Skill           | Description                    | Documentation                                                                                    |
| --------------- | ------------------------------ | ------------------------------------------------------------------------------------------------ |
| `skill-creator` | Creates new AI agent skills    | [~/.conf/opencode/skills/skill-creator/SKILL.md](~/.conf/opencode/skills/skill-creator/SKILL.md) |
| `project-init`  | Initializes OpenCode workspace | [~/.conf/opencode/skills/project-init/SKILL.md](~/.conf/opencode/skills/project-init/SKILL.md)   |

## Adding Skills

- **Global**: Add to `~/.conf/opencode/skills/` (available to all projects)
- **Project-local**: Add to `.opencode/skills/` (this project only)

See [skill-creator](~/.conf/opencode/skills/skill-creator/SKILL.md) for details.
```

## Commands

```bash
# Verify OpenCode installation
[ -d "$HOME/.conf/opencode" ] && echo "✓ OpenCode installed" || echo "✗ OpenCode not found"

# Check project initialization
[ -f "AGENTS.md" ] && echo "✓ Project initialized" || echo "✗ Not initialized"

# List global skills
find ~/.conf/opencode/skills -name "SKILL.md" -type f

# List project-local skills
[ -d ".opencode/skills" ] && find .opencode/skills -name "SKILL.md" -type f || echo "No local skills"

# Sync skills from OpenCode
rsync -av ~/.conf/opencode/skills/ .opencode/skills/ --exclude=".git"
```

## Initialization Workflow

1. **Verify OpenCode Installation**
   - Check `~/.conf/opencode/` exists
   - If missing: Error and exit

2. **Check Current Directory**
   - Ensure in project root (not in subdirectory)
   - Verify not accidentally in ~/.conf/opencode

3. **Create AGENTS.md**
   - If missing: Create from template
   - If exists: Validate format and update global skills list

4. **Scan Available Skills**
   - List global skills from `~/.conf/opencode/skills/`
   - List project-local skills from `.opencode/skills/` (if exists)
   - Update AGENTS.md with current skill inventory

5. **Report Status**
   - Show initialized status
   - List available global skills
   - List project-local skills (if any)
   - Suggest next steps

## Skill Loading Priority

1. `.opencode/skills/{skill-name}/` (project-local, highest priority)
2. `~/.conf/opencode/skills/{skill-name}/` (global)

**Rule**: Project-local skills override global skills with same name.

## Registration Rules

- Global skills: Link to `~/.conf/opencode/skills/{skill-name}/SKILL.md`
- Local skills: Link to `.opencode/skills/{skill-name}/SKILL.md`
- Format: `| \`{skill-name}\` | {Description} | [{path}]({path}) |`
- Auto-discover and register all skills on init

## Resources

- **Templates**: See [assets/](assets/) for AGENTS.md template
- **OpenCode Docs**: `~/.conf/opencode/README.md`
