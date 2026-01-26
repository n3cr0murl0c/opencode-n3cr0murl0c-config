#!/bin/bash
# ============================================================================
# .Dots AI Skills Setup Script
# ============================================================================
# This script synchronizes AGENTS.md to tool-specific instruction files.
# AGENTS.md is the single source of truth - edits propagate to all tools.
#
# Usage:
#   ~/.config/opencode/skills/setup.sh              # Interactive menu
#   ~/.config/opencode/skills/setup.sh --all        # Generate all formats
#   ~/.config/opencode/skills/setup.sh --claude     # Generate CLAUDE.md only
#   ~/.config/opencode/skills/setup.sh --gemini     # Generate GEMINI.md only
#   ~/.config/opencode/skills/setup.sh --copilot    # Generate .github/copilot-instructions.md
#   ~/.config/opencode/skills/setup.sh --codex      # Generate CODEX.md only
#   ~/.config/opencode/skills/setup.sh --link-all   # Create symlinks to all AI configs
#   ~/.config/opencode/skills/setup.sh --unlink-all # Remove all symlinks
#
# ============================================================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

# Script directory
SCRIPT_DIR="~/.config/opencode/skills/"

# Default to current directory where script is invoked
REPO_ROOT="$(pwd)"

# Source directory for skills (single source of truth)
OPENCODE_CONFIG="$HOME/.config/opencode"

# Target directories for AI assistants
CLAUDE_CONFIG="$HOME/.claude"
GEMINI_CONFIG="$HOME/.gemini"
COPILOT_CONFIG="$HOME/.github"

# Parse --dir argument if provided
for arg in "$@"; do
    if [ "$prev_arg" = "--dir" ]; then
        REPO_ROOT="$arg"
        break
    fi
    prev_arg="$arg"
done


# ============================================================================
# Utility Functions
# ============================================================================

log_info() {
    printf "${BLUE}[INFO]${NC} %s\n" "$1"
}

log_success() {
    printf "${GREEN}[SUCCESS]${NC} %s\n" "$1"
}

log_warning() {
    printf "${YELLOW}[WARNING]${NC} %s\n" "$1"
}

log_error() {
    printf "${RED}[ERROR]${NC} %s\n" "$1"
}

log_header() {
    printf "\n${CYAN}${BOLD}════════════════════════════════════════${NC}\n"
    printf "${CYAN}${BOLD}  %s${NC}\n" "$1"
    printf "${CYAN}${BOLD}════════════════════════════════════════${NC}\n\n"
}

# ============================================================================
# Symlink Management Functions
# ============================================================================

# Create a symlink safely (backup existing files/dirs)
safe_symlink() {
    local source="$1"
    local target="$2"
    local target_dir=$(dirname "$target")

    # Create target directory if it doesn't exist
    mkdir -p "$target_dir"

    # Handle existing target
    if [ -e "$target" ] || [ -L "$target" ]; then
        if [ -L "$target" ]; then
            local current_link=$(readlink "$target")
            if [ "$current_link" = "$source" ]; then
                log_info "Symlink already exists: $target -> $source"
                return 0
            else
                log_warning "Removing old symlink: $target -> $current_link"
                rm "$target"
            fi
        else
            local backup="${target}.backup.$(date +%Y%m%d_%H%M%S)"
            log_warning "Backing up existing: $target -> $backup"
            mv "$target" "$backup"
        fi
    fi

    ln -s "$source" "$target"
    log_success "Created symlink: $target -> $source"
}

# Remove a symlink if it points to opencode config
safe_unlink() {
    local target="$1"

    if [ -L "$target" ]; then
        local link_target=$(readlink "$target")
        if [[ "$link_target" == *".config/opencode"* ]]; then
            rm "$target"
            log_success "Removed symlink: $target"
        else
            log_warning "Skipping (not an opencode symlink): $target"
        fi
    elif [ -e "$target" ]; then
        log_warning "Skipping (not a symlink): $target"
    else
        log_info "Not found: $target"
    fi
}

# Link skills directory to Claude
link_claude_skills() {
    log_info "Linking skills to Claude Code..."
    safe_symlink "$OPENCODE_CONFIG/skill" "$CLAUDE_CONFIG/skills"
}

# Link skills to Gemini
link_gemini_skills() {
    log_info "Linking skills to Gemini..."
    safe_symlink "$OPENCODE_CONFIG/skill" "$GEMINI_CONFIG/skills"
}

# Link commands to Claude
link_claude_commands() {
    log_info "Linking commands to Claude Code..."
    if [ -d "$OPENCODE_CONFIG/commands" ]; then
        safe_symlink "$OPENCODE_CONFIG/commands" "$CLAUDE_CONFIG/commands"
    fi
}

# Link agents to Claude
link_claude_agents() {
    log_info "Linking agents to Claude Code..."
    if [ -d "$OPENCODE_CONFIG/agents" ]; then
        safe_symlink "$OPENCODE_CONFIG/agents" "$CLAUDE_CONFIG/agents"
    fi
}

# Create all symlinks
link_all_configs() {
    log_header "Creating Symlinks to ~/.config/opencode"

    local opencode_base="$HOME/.config/opencode"
    local opencode_skill_dir=""

    # Buscar directorio de skills (puede ser 'skill' o 'skills')
    if [ -d "$opencode_base/skills" ]; then
        opencode_skill_dir="$opencode_base/skills"
    elif [ -d "$opencode_base/skill" ]; then
        opencode_skill_dir="$opencode_base/skill"
    else
        log_error "No skills directory found in $opencode_base"
        log_info "Please create either ~/.config/opencode/skill or ~/.config/opencode/skills"
        exit 1
    fi

    # Link skills
    log_info "Linking skills directory..."
    safe_symlink "$opencode_skill_dir" "$CLAUDE_CONFIG/skills"
    safe_symlink "$opencode_skill_dir" "$GEMINI_CONFIG/skills"

    # Link commands if exist
    if [ -d "$opencode_base/commands" ]; then
        log_info "Linking commands directory..."
        safe_symlink "$opencode_base/commands" "$CLAUDE_CONFIG/commands"
        safe_symlink "$opencode_base/commands" "$GEMINI_CONFIG/commands"
    fi

    # Link agents if exist
    if [ -d "$opencode_base/agents" ]; then
        log_info "Linking agents directory..."
        safe_symlink "$opencode_base/agents" "$CLAUDE_CONFIG/agents"
        safe_symlink "$opencode_base/agents" "$GEMINI_CONFIG/agents"
    fi

    log_success "All symlinks created!"
    echo ""
    log_info "Configuration structure:"
    echo "  $opencode_skill_dir     → Single source of truth"
    echo "  ~/.claude/skills             → Symlink"
    echo "  ~/.gemini/skills             → Symlink"
    if [ -d "$opencode_base/commands" ]; then
        echo "  ~/.claude/commands           → Symlink"
        echo "  ~/.gemini/commands           → Symlink"
    fi
    if [ -d "$opencode_base/agents" ]; then
        echo "  ~/.claude/agents             → Symlink"
        echo "  ~/.gemini/agents             → Symlink"
    fi
}

# Remove all symlinks
unlink_all_configs() {
    log_header "Removing OpenCode Symlinks"

    safe_unlink "$CLAUDE_CONFIG/skills"
    safe_unlink "$CLAUDE_CONFIG/commands"
    safe_unlink "$CLAUDE_CONFIG/agents"
    safe_unlink "$GEMINI_CONFIG/skills"
    safe_unlink "$GEMINI_CONFIG/commands"
    safe_unlink "$GEMINI_CONFIG/agents"

    log_success "All symlinks removed!"
}

# Check symlink status
check_symlinks() {
    log_header "Symlink Status"

    local dirs=(
        "$CLAUDE_CONFIG/skills"
        "$CLAUDE_CONFIG/commands"
        "$CLAUDE_CONFIG/agents"
        "$GEMINI_CONFIG/skills"
        "$GEMINI_CONFIG/commands"
        "$GEMINI_CONFIG/agents"
    )

    for dir in "${dirs[@]}"; do
        if [ -L "$dir" ]; then
            local target=$(readlink "$dir")
            printf "${GREEN}✓${NC} %-30s → %s\n" "$dir" "$target"
        elif [ -e "$dir" ]; then
            printf "${YELLOW}●${NC} %-30s (not a symlink)\n" "$dir"
        else
            printf "${RED}✗${NC} %-30s (not found)\n" "$dir"
        fi
    done
}

# ============================================================================
# Generation Functions
# ============================================================================

# Find all AGENTS.md files in the repository
find_agents_files() {
    find "$REPO_ROOT" -name "AGENTS.md" -type f 2>/dev/null
}

# Generate CLAUDE.md from AGENTS.md
generate_claude() {
    local agents_file="$1"
    local dir=$(dirname "$agents_file")
    local claude_file="$dir/CLAUDE.md"

    log_info "Generating CLAUDE.md from $agents_file"

    cat > "$claude_file" << 'EOF'
# Claude Code Instructions

> **Auto-generated from AGENTS.md** - Do not edit directly.
> Run `~/.config/opencode/skills/setup.sh --claude` to regenerate.

EOF

    cat "$agents_file" >> "$claude_file"
    log_success "Created $claude_file"
}

# Generate GEMINI.md from AGENTS.md
generate_gemini() {
    local agents_file="$1"
    local dir=$(dirname "$agents_file")
    local gemini_file="$dir/GEMINI.md"

    cat > "$gemini_file" << 'EOF'
# Gemini CLI Instructions

> **Auto-generated from AGENTS.md** - Do not edit directly.
> Run `~/.config/opencode/skills/setup.sh --gemini` to regenerate.

EOF

    cat "$agents_file" >> "$gemini_file"
    log_success "Created $gemini_file"
}

# Generate .github/copilot-instructions.md from AGENTS.md
generate_copilot() {
    local agents_file="$1"
    local dir=$(dirname "$agents_file")
    local copilot_dir="$dir/.github"
    local copilot_file="$copilot_dir/copilot-instructions.md"

    log_info "Generating copilot-instructions.md from $agents_file"

    mkdir -p "$copilot_dir"

    cat > "$copilot_file" << 'EOF'
# GitHub Copilot Instructions

> **Auto-generated from AGENTS.md** - Do not edit directly.
> Run `~/.config/opencode/skills/setup.sh --copilot` to regenerate.

EOF

    cat "$agents_file" >> "$copilot_file"
    log_success "Created $copilot_file"
}

# Generate CODEX.md from AGENTS.md
generate_codex() {
    local agents_file="$1"
    local dir=$(dirname "$agents_file")
    local codex_file="$dir/CODEX.md"

    log_info "Generating CODEX.md from $agents_file"

    cat > "$codex_file" << 'EOF'
# OpenAI Codex Instructions

> **Auto-generated from AGENTS.md** - Do not edit directly.
> Run `~/.config/opencode/skills/setup.sh --codex` to regenerate.

EOF

    cat "$agents_file" >> "$codex_file"
    log_success "Created $codex_file"
}

# Sync FROM OpenCode TO other AI agent configs (copy mode)
sync_from_opencode() {
    local opencode_base="$HOME/.config/opencode"
    local opencode_skill_dir=""
    local opencode_commands_dir="$opencode_base/commands"
    local opencode_agents_dir="$opencode_base/agents"

    log_info "Syncing FROM OpenCode TO AI agent configs..."

    # Buscar directorio de skills (puede ser 'skill' o 'skills')
    if [ -d "$opencode_base/skills" ]; then
        opencode_skill_dir="$opencode_base/skills"
        log_info "Found skills directory: $opencode_skill_dir"
    elif [ -d "$opencode_base/skill" ]; then
        opencode_skill_dir="$opencode_base/skill"
        log_info "Found skill directory: $opencode_skill_dir"
    else
        log_error "No skills directory found in $opencode_base"
        log_info "Please create either ~/.config/opencode/skill or ~/.config/opencode/skills"
        exit 1
    fi

    # Sync to Claude
    log_info "Syncing to Claude Code (~/.claude)..."
    local synced_claude=false

    if [ -d "$opencode_skill_dir" ] && [ "$(ls -A "$opencode_skill_dir" 2>/dev/null)" ]; then
        mkdir -p "$CLAUDE_CONFIG/skills"
        cp -rf "$opencode_skill_dir"/* "$CLAUDE_CONFIG/skills/"
        log_success "  ✓ Copied skills"
        synced_claude=true
    fi

    if [ -d "$opencode_commands_dir" ] && [ "$(ls -A "$opencode_commands_dir" 2>/dev/null)" ]; then
        mkdir -p "$CLAUDE_CONFIG/commands"
        cp -rf "$opencode_commands_dir"/* "$CLAUDE_CONFIG/commands/"
        log_success "  ✓ Copied commands"
        synced_claude=true
    fi

    if [ -d "$opencode_agents_dir" ] && [ "$(ls -A "$opencode_agents_dir" 2>/dev/null)" ]; then
        mkdir -p "$CLAUDE_CONFIG/agents"
        cp -rf "$opencode_agents_dir"/* "$CLAUDE_CONFIG/agents/"
        log_success "  ✓ Copied agents"
        synced_claude=true
    fi

    if [ "$synced_claude" = false ]; then
        log_warning "  No content found to sync to Claude"
    fi

    # Sync to Gemini
    log_info "Syncing to Gemini CLI (~/.gemini)..."
    local synced_gemini=false

    if [ -d "$opencode_skill_dir" ] && [ "$(ls -A "$opencode_skill_dir" 2>/dev/null)" ]; then
        mkdir -p "$GEMINI_CONFIG/skills"
        cp -rf "$opencode_skill_dir"/* "$GEMINI_CONFIG/skills/"
        log_success "  ✓ Copied skills"
        synced_gemini=true
    fi

    if [ -d "$opencode_commands_dir" ] && [ "$(ls -A "$opencode_commands_dir" 2>/dev/null)" ]; then
        mkdir -p "$GEMINI_CONFIG/commands"
        cp -rf "$opencode_commands_dir"/* "$GEMINI_CONFIG/commands/"
        log_success "  ✓ Copied commands"
        synced_gemini=true
    fi

    if [ "$synced_gemini" = false ]; then
        log_warning "  No content found to sync to Gemini"
    fi

    log_success "Sync complete! OpenCode config shared with all agents"
}

# Generate all formats for a single AGENTS.md
generate_all_for_file() {
    local agents_file="$1"

    generate_claude "$agents_file"
    generate_gemini "$agents_file"
    generate_copilot "$agents_file"
    generate_codex "$agents_file"
}

# Generate all formats for all AGENTS.md files
generate_all() {
    log_header "Generating All Formats"

    local agents_files=$(find_agents_files)

    if [ -z "$agents_files" ]; then
        log_error "No AGENTS.md files found in repository"
        exit 1
    fi

    for agents_file in $agents_files; do
        log_info "Processing: $agents_file"
        generate_all_for_file "$agents_file"
        echo ""
    done

    log_success "All formats generated!"
}

# ============================================================================
# Interactive Menu
# ============================================================================

show_menu() {
    log_header ".Dots AI Skills Setup"

    echo "This script synchronizes AGENTS.md to tool-specific formats."
    echo "AGENTS.md is the single source of truth for all AI assistants."
    echo ""
    echo "Select which assistants to configure:"
    echo ""
    echo "  ${CYAN}1)${NC} Claude Code      (CLAUDE.md)"
    echo "  ${CYAN}2)${NC} Gemini CLI       (GEMINI.md)"
    echo "  ${CYAN}3)${NC} GitHub Copilot   (.github/copilot-instructions.md)"
    echo "  ${CYAN}4)${NC} OpenAI Codex     (CODEX.md)"
    echo "  ${CYAN}5)${NC} All of the above"
    echo ""
    echo "  ${CYAN}6)${NC} Sync FROM OpenCode TO agents (copy)"
    echo "  ${CYAN}7)${NC} Create symlinks (share config)"
    echo "  ${CYAN}8)${NC} Remove symlinks"
    echo "  ${CYAN}9)${NC} Check symlink status"
    echo ""
    echo "  ${CYAN}0)${NC} Exit"
    echo ""
    printf "Enter choice [0-9]: "
}

handle_menu_choice() {
    local choice="$1"
    local agents_file="$REPO_ROOT/AGENTS.md"

    case $choice in
        1)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_claude "$agents_file"
            ;;
        2)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_gemini "$agents_file"
            ;;
        3)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_copilot "$agents_file"
            ;;
        4)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_codex "$agents_file"
            ;;
        5)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_all_for_file "$agents_file"
            ;;
        6)
            sync_from_opencode
            ;;
        7)
            link_all_configs
            ;;
        8)
            unlink_all_configs
            ;;
        9)
            check_symlinks
            ;;
        0)
            log_info "Exiting..."
            exit 0
            ;;
        *)
            log_error "Invalid choice: $choice"
            exit 1
            ;;
    esac
}

interactive_menu() {
    show_menu
    read -r choice
    handle_menu_choice "$choice"
}

# ============================================================================
# CLI Argument Parsing
# ============================================================================

show_help() {
    cat << EOF
.Dots AI Skills Setup

Usage: ~/.config/opencode/skills/setup.sh [OPTIONS]

Options:
  --claude        Generate CLAUDE.md from AGENTS.md
  --gemini        Generate GEMINI.md from AGENTS.md
  --copilot       Generate .github/copilot-instructions.md
  --codex         Generate CODEX.md from AGENTS.md
  --all           Generate all format-specific files
  --sync          Sync FROM ~/.config/opencode TO all agents (copy mode)
  --link-all      Create symlinks from AI configs to ~/.config/opencode
  --unlink-all    Remove all symlinks
  --check-links   Check symlink status
  --help          Show this help message

Examples:
  ~/.config/opencode/skills/setup.sh                # Interactive menu
  ~/.config/opencode/skills/setup.sh --all          # Generate all formats
  ~/.config/opencode/skills/setup.sh --sync         # Sync from opencode
  ~/.config/opencode/skills/setup.sh --link-all     # Share via symlinks
  ~/.config/opencode/skills/setup.sh --check-links  # Verify symlinks

Workflow:
  1. Edit your config in ~/.config/opencode (single source of truth)
  2. Run --link-all to create symlinks (recommended)
     OR run --sync to copy to all agents
  3. Changes in ~/.config/opencode appear in all AI tools
EOF
}

parse_args() {
    local agents_file="$REPO_ROOT/AGENTS.md"

    case "$1" in
        --claude)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_claude "$agents_file"
            ;;
        --gemini)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_gemini "$agents_file"
            ;;
        --copilot)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_copilot "$agents_file"
            ;;
        --codex)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_codex "$agents_file"
            ;;
        --all)
            if [ ! -f "$agents_file" ]; then
                log_error "AGENTS.md not found at $agents_file"
                exit 1
            fi
            generate_all_for_file "$agents_file"
            ;;
        --sync)
            sync_from_opencode
            ;;
        --link-all)
            link_all_configs
            ;;
        --unlink-all)
            unlink_all_configs
            ;;
        --check-links)
            check_symlinks
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        *)
            log_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
}

# ============================================================================
# Main
# ============================================================================

main() {
    echo "using vars: $REPO_ROOT and $SCRIPT_DIR"
    cd "$REPO_ROOT"

    if [ $# -eq 0 ]; then
        interactive_menu
    else
        parse_args "$@"
    fi

    echo ""
    log_success "Done!"
}

main "$@"
