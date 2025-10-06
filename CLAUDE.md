# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**VIBECONTROL** is a file-based context management protocol for LLM-assisted development. This repository contains the protocol specification itself, not a project that uses the protocol.

**Read README.md for complete project background and purpose.**

## Repository Architecture

This is a **meta-repository**: it defines a protocol that other projects will use, but does not itself use VIBECONTROL for development.

### Core Files

- **README.md** - User-facing documentation explaining what VIBECONTROL is, why it exists, and how to use it
- **VIBECONTROL.md** - The protocol specification itself; instructions for LLM assistants on how to maintain context in VIBECONTROL-managed projects
- **docs/** - Example directory structure that projects will create when implementing VIBECONTROL

### Key Architectural Concepts

**Two Audiences:**
1. **Human developers** read README.md to understand and adopt VIBECONTROL
2. **LLM assistants** read VIBECONTROL.md to follow the protocol in managed projects

**The Protocol vs. Implementation:**
- VIBECONTROL.md defines the protocol (rules, procedures, file formats)
- README.md explains the benefits and use cases
- docs/ structure is an empty scaffold showing the file organization

**Modularity:**
The protocol supports different "setups" (minimal, standard, full, custom). This modularity is reflected in:
- Optional modules described in VIBECONTROL.md (plans/, knowledge/, schema/, proc/)
- Flexibility language throughout both documents
- No prescriptive enforcement

## Working in This Repository

### Making Changes to the Protocol

When modifying VIBECONTROL.md:
- Consider impact on both new and existing users
- Maintain backward compatibility where possible
- Update README.md if user-facing features change
- Keep examples in sync with protocol definitions
- Preserve the modular design philosophy

### README.md and VIBECONTROL.md Relationship

**Maintain consistency:**
- File structure described in README.md must match VIBECONTROL.md specifications
- Examples in README.md must follow formats defined in VIBECONTROL.md
- Terminology should be consistent across both files

**Division of concerns:**
- README.md: Benefits, philosophy, use cases, getting started
- VIBECONTROL.md: Technical procedures, formats, rules, operational details

### Documentation Style

Both files use:
- Clear section hierarchies
- Concrete examples over abstract descriptions
- Markdown formatting for readability
- Direct, concise language optimized for both human and LLM comprehension

## Key Design Principles

Understanding these principles helps maintain protocol coherence:

1. **Files over abstractions** - Everything is a markdown file; no custom tooling required
2. **LLM-first design** - Protocol optimized for LLM comprehension and execution
3. **Git-native** - Leverages version control semantics developers already understand
4. **Progressive disclosure** - Start simple (just progress.md), add complexity only when needed
5. **Tool-agnostic** - Works with any LLM (Claude, ChatGPT, Cursor, Copilot, etc.)
6. **Zero dependencies** - No frameworks, platforms, or external services

## Common Development Tasks

This repository has no build system, test suite, or package management. Development consists of:

**Editing protocol documentation:**
```bash
# Edit the protocol specification
open VIBECONTROL.md

# Edit user-facing docs
open README.md
```

**Reviewing changes:**
```bash
# View what changed
git diff

# Check history
git log --oneline
```

## Important Distinctions

**This repository is NOT:**
- A software project with code to build or test
- An example of VIBECONTROL in use (it's the protocol definition itself)
- A framework or library with dependencies
- A tool that needs installation

**This repository IS:**
- The source of truth for VIBECONTROL protocol
- Documentation defining how other projects should structure their LLM context
- A specification that evolves based on real-world usage feedback

## Future Development Considerations

As VIBECONTROL evolves, potential additions might include:
- Installation scripts (mentioned in README but not yet created)
- Example projects demonstrating the protocol
- Integration guides for specific tools (Cursor, MCP servers, etc.)
- Templates for common project types

When adding these, maintain the core principle: **VIBECONTROL remains a protocol, not a platform**.
