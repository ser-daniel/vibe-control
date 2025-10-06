#!/usr/bin/env bash
# VIBECONTROL Installation Script
# Version: 1.0.0
# Usage: bash install.sh [--minimal|--standard|--full|--custom]

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
SETUP_TYPE=""
TARGET_DIR="$(pwd)"
DOCS_DIR="${TARGET_DIR}/docs"

# Script location (for copying VIBECONTROL.md)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_header() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║      VIBECONTROL INSTALLATION            ║"
    echo "║  Context Management for LLM Development  ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

show_help() {
    cat << EOF
VIBECONTROL Installation Script

Usage:
  ./install.sh [OPTIONS]

Options:
  --minimal     Create only progress.md (simple projects, solo dev)
  --standard    Create progress.md + plans/ + knowledge/ (most projects)
  --full        Create all modules including schema/ and proc/
  --custom      Interactively choose modules
  --help        Show this help message

Examples:
  ./install.sh --standard
  ./install.sh --custom
  bash <(curl -sSL https://raw.githubusercontent.com/YOUR_USERNAME/vibecontrol/main/install.sh) --standard

EOF
}

prompt_setup_type() {
    echo ""
    echo "Choose your VIBECONTROL setup:"
    echo ""
    echo "1) Minimal   - progress.md only (simple projects, solo dev)"
    echo "2) Standard  - progress.md + plans/ + knowledge/ (recommended)"
    echo "3) Full      - All modules: plans/, knowledge/, schema/, proc/"
    echo "4) Custom    - Choose specific modules"
    echo ""

    while true; do
        read -p "Enter choice [1-4]: " choice
        case $choice in
            1) SETUP_TYPE="minimal"; break;;
            2) SETUP_TYPE="standard"; break;;
            3) SETUP_TYPE="full"; break;;
            4) SETUP_TYPE="custom"; break;;
            *) print_error "Invalid choice. Please enter 1-4.";;
        esac
    done
}

prompt_custom_modules() {
    echo ""
    echo "Select modules to install (y/n for each):"
    echo ""

    read -p "plans/ - Task breakdowns and roadmaps? [Y/n]: " install_plans
    install_plans=${install_plans:-Y}

    read -p "knowledge/ - Stable reference material? [Y/n]: " install_knowledge
    install_knowledge=${install_knowledge:-Y}

    read -p "schema/ - Architecture diagrams (Mermaid)? [y/N]: " install_schema
    install_schema=${install_schema:-N}

    read -p "proc/ - Debug logs and context snapshots? [y/N]: " install_proc
    install_proc=${install_proc:-N}
}

create_docs_structure() {
    print_info "Creating docs/ directory structure..."

    # Create main docs directory
    mkdir -p "${DOCS_DIR}"
    print_success "Created docs/"

    # Determine modules list based on setup type (BEFORE creating progress.md)
    local modules_list=""
    case $SETUP_TYPE in
        minimal)
            modules_list=""
            ;;
        standard)
            modules_list=", plans/, knowledge/"
            ;;
        full)
            modules_list=", plans/, knowledge/, schema/, proc/"
            ;;
        custom)
            modules_list=""
            [[ "${install_plans}" =~ ^[Yy]$ ]] && modules_list="${modules_list}, plans/"
            [[ "${install_knowledge}" =~ ^[Yy]$ ]] && modules_list="${modules_list}, knowledge/"
            [[ "${install_schema}" =~ ^[Yy]$ ]] && modules_list="${modules_list}, schema/"
            [[ "${install_proc}" =~ ^[Yy]$ ]] && modules_list="${modules_list}, proc/"
            ;;
    esac

    # Get current date (compatible with both macOS and Linux)
    local current_date
    if date --version >/dev/null 2>&1; then
        # GNU date (Linux)
        current_date=$(date -u +"%Y-%m-%d %H:%M UTC")
    else
        # BSD date (macOS)
        current_date=$(date -u +"%Y-%m-%d %H:%M UTC")
    fi

    # Create progress.md (always created)
    if [ ! -f "${DOCS_DIR}/progress.md" ]; then
        cat > "${DOCS_DIR}/progress.md" << EOF
# Project Progress Log

This file tracks all significant work completed in this project. Each entry should follow the VIBECONTROL format.

## Format

\`\`\`markdown
## YYYY-MM-DD HH:MM UTC

### [Brief descriptive title]
**Context:** Why this work was needed
**Changes:** What was actually done (specific file paths, function names, commands)
**Outcome:** What works now that didn't before
**Issues:** Problems encountered or remaining concerns
**Next:** Logical next steps (if known)
\`\`\`

---

## Project Started

**Date:** ${current_date}

This project now uses VIBECONTROL for context management.

**Setup:** ${SETUP_TYPE}
**Modules:** progress.md${modules_list}

**Next:** Start working and let your AI assistant maintain this log!

---
EOF
        print_success "Created progress.md"
    else
        print_warning "progress.md already exists, skipping..."
    fi

    # Copy VIBECONTROL.md
    if [ ! -f "${DOCS_DIR}/VIBECONTROL.md" ]; then
        if [ -f "${SCRIPT_DIR}/VIBECONTROL.md" ]; then
            cp "${SCRIPT_DIR}/VIBECONTROL.md" "${DOCS_DIR}/VIBECONTROL.md"
            print_success "Copied VIBECONTROL.md"
        else
            print_warning "VIBECONTROL.md not found in script directory"
            print_info "You can download it manually from the VIBECONTROL repository"
        fi
    else
        print_warning "VIBECONTROL.md already exists, skipping..."
    fi

    # Create optional directories based on setup type
    case $SETUP_TYPE in
        minimal)
            # No additional directories
            ;;
        standard)
            mkdir -p "${DOCS_DIR}/plans" "${DOCS_DIR}/knowledge"
            create_readme "${DOCS_DIR}/plans" "Task breakdowns and roadmaps"
            create_readme "${DOCS_DIR}/knowledge" "Stable reference material and patterns"
            print_success "Created plans/ and knowledge/"
            ;;
        full)
            mkdir -p "${DOCS_DIR}/plans" "${DOCS_DIR}/knowledge" "${DOCS_DIR}/schema" "${DOCS_DIR}/proc"
            create_readme "${DOCS_DIR}/plans" "Task breakdowns and roadmaps"
            create_readme "${DOCS_DIR}/knowledge" "Stable reference material and patterns"
            create_readme "${DOCS_DIR}/schema" "Architecture diagrams (Mermaid format)"
            create_readme "${DOCS_DIR}/proc" "Process logs, debugging traces, context snapshots"
            print_success "Created plans/, knowledge/, schema/, and proc/"
            ;;
        custom)
            if [[ "${install_plans}" =~ ^[Yy]$ ]]; then
                mkdir -p "${DOCS_DIR}/plans"
                create_readme "${DOCS_DIR}/plans" "Task breakdowns and roadmaps"
                print_success "Created plans/"
            fi
            if [[ "${install_knowledge}" =~ ^[Yy]$ ]]; then
                mkdir -p "${DOCS_DIR}/knowledge"
                create_readme "${DOCS_DIR}/knowledge" "Stable reference material and patterns"
                print_success "Created knowledge/"
            fi
            if [[ "${install_schema}" =~ ^[Yy]$ ]]; then
                mkdir -p "${DOCS_DIR}/schema"
                create_readme "${DOCS_DIR}/schema" "Architecture diagrams (Mermaid format)"
                print_success "Created schema/"
            fi
            if [[ "${install_proc}" =~ ^[Yy]$ ]]; then
                mkdir -p "${DOCS_DIR}/proc"
                create_readme "${DOCS_DIR}/proc" "Process logs, debugging traces, context snapshots"
                print_success "Created proc/"
            fi
            ;;
    esac
}

create_readme() {
    local dir=$1
    local description=$2

    if [ ! -f "${dir}/README.md" ]; then
        cat > "${dir}/README.md" << EOF
# $(basename "$dir")

${description}

See docs/VIBECONTROL.md for detailed usage instructions.
EOF
    fi
}

update_project_readme() {
    if [ ! -f "${TARGET_DIR}/README.md" ]; then
        print_info "No README.md found, skipping update..."
        return
    fi

    read -p "Update README.md with VIBECONTROL reference? [Y/n]: " update_readme
    update_readme=${update_readme:-Y}

    if [[ "${update_readme}" =~ ^[Yy]$ ]]; then
        if ! grep -q "VIBECONTROL" "${TARGET_DIR}/README.md"; then
            cat >> "${TARGET_DIR}/README.md" << 'EOF'

## AI Assistant Guidelines

This project uses VIBECONTROL for context management. When using AI coding assistants:

1. Read `docs/VIBECONTROL.md` at session start
2. Check `docs/progress.md` for recent work
3. Update documentation as you work
4. Follow the protocol for task management and knowledge capture

See [docs/VIBECONTROL.md](docs/VIBECONTROL.md) for complete instructions.
EOF
            print_success "Updated README.md with VIBECONTROL reference"
        else
            print_warning "README.md already mentions VIBECONTROL, skipping..."
        fi
    fi
}

update_claude_md() {
    if [ ! -f "${TARGET_DIR}/CLAUDE.md" ]; then
        read -p "Create CLAUDE.md with VIBECONTROL instructions? [Y/n]: " create_claude
        create_claude=${create_claude:-Y}

        if [[ "${create_claude}" =~ ^[Yy]$ ]]; then
            cat > "${TARGET_DIR}/CLAUDE.md" << 'EOF'
# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Context Management

This project uses VIBECONTROL for persistent context management.

**At session start:**
1. Read `docs/VIBECONTROL.md` for complete protocol instructions
2. Read recent entries in `docs/progress.md` to understand current state
3. Check `docs/plans/` for active tasks
4. Load relevant `docs/knowledge/` files for context

**During work:**
- Document decisions immediately
- Update task status as work completes
- Extract patterns to `docs/knowledge/`
- Generate diagrams in `docs/schema/` when needed

**Before session end:**
- Log completed work to `docs/progress.md`
- Update task completion in `docs/plans/`
- Create checkpoint if context-heavy

See [docs/VIBECONTROL.md](docs/VIBECONTROL.md) for detailed procedures.
EOF
            print_success "Created CLAUDE.md"
        fi
    else
        print_info "CLAUDE.md already exists, consider manually adding VIBECONTROL reference"
    fi
}

create_gitignore_entries() {
    local gitignore="${TARGET_DIR}/.gitignore"

    read -p "Add docs/proc/ to .gitignore (debug logs)? [y/N]: " ignore_proc
    ignore_proc=${ignore_proc:-N}

    if [[ "${ignore_proc}" =~ ^[Yy]$ ]]; then
        if [ -f "$gitignore" ]; then
            if ! grep -q "docs/proc/" "$gitignore"; then
                echo "" >> "$gitignore"
                echo "# VIBECONTROL process logs (optional)" >> "$gitignore"
                echo "docs/proc/" >> "$gitignore"
                print_success "Added docs/proc/ to .gitignore"
            else
                print_warning "docs/proc/ already in .gitignore"
            fi
        else
            echo "docs/proc/" > "$gitignore"
            print_success "Created .gitignore with docs/proc/"
        fi
    fi
}

show_next_steps() {
    echo ""
    echo -e "${GREEN}╔══════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║     INSTALLATION COMPLETE! 🎉            ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════╝${NC}"
    echo ""
    echo "Next steps:"
    echo ""
    echo "1. Tell your AI assistant:"
    echo -e "   ${BLUE}\"This project uses VIBECONTROL. Please read docs/VIBECONTROL.md.\"${NC}"
    echo ""
    echo "2. Start working:"
    echo -e "   ${BLUE}\"Let's implement [feature]. Create a plan first.\"${NC}"
    echo ""
    echo "3. Your AI will:"
    echo "   • Read the protocol and current context"
    echo "   • Maintain documentation as it works"
    echo "   • Update progress.md after each session"
    echo ""
    echo "Files created:"
    echo "   • docs/VIBECONTROL.md - Protocol instructions for AI"
    echo "   • docs/progress.md - Your project's memory"
    if [[ "$SETUP_TYPE" != "minimal" ]]; then
        echo "   • docs/plans/ - Task breakdowns"
        echo "   • docs/knowledge/ - Reference material"
    fi
    if [[ "$SETUP_TYPE" == "full" ]] || [[ "${install_schema}" =~ ^[Yy]$ ]]; then
        echo "   • docs/schema/ - Architecture diagrams"
    fi
    if [[ "$SETUP_TYPE" == "full" ]] || [[ "${install_proc}" =~ ^[Yy]$ ]]; then
        echo "   • docs/proc/ - Debug logs and snapshots"
    fi
    echo ""
    echo -e "Documentation: ${BLUE}docs/VIBECONTROL.md${NC}"
    echo -e "Learn more: ${BLUE}https://github.com/YOUR_USERNAME/vibecontrol${NC}"
    echo ""
}

# Main installation flow
main() {
    print_header

    # Parse command line arguments
    case "${1:-}" in
        --minimal)
            SETUP_TYPE="minimal"
            ;;
        --standard)
            SETUP_TYPE="standard"
            ;;
        --full)
            SETUP_TYPE="full"
            ;;
        --custom)
            SETUP_TYPE="custom"
            prompt_custom_modules
            ;;
        --help|-h)
            show_help
            exit 0
            ;;
        "")
            prompt_setup_type
            if [ "$SETUP_TYPE" == "custom" ]; then
                prompt_custom_modules
            fi
            ;;
        *)
            print_error "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac

    echo ""
    print_info "Installing VIBECONTROL (${SETUP_TYPE} setup)..."
    echo ""

    # Create directory structure
    create_docs_structure

    # Optional updates
    echo ""
    update_project_readme
    update_claude_md
    create_gitignore_entries

    # Show completion message
    show_next_steps
}

# Run installation
main "$@"
