# Meta-Repository Architecture

**Last Updated:** 2025-10-06
**Stability:** Stable

## Summary

VIBECONTROL repository is a "meta-repository" - it defines a protocol that other projects will use, but does not itself implement the protocol's intended use case. Understanding this distinction is critical for maintaining the project coherently.

## What is a Meta-Repository?

A meta-repository contains:
- **Specification:** The protocol definition (VIBECONTROL.md)
- **Documentation:** User-facing explanations (README.md)
- **Tooling:** Installation scripts (install.sh, install.js, install.py)
- **Examples:** Demonstration of the protocol in action
- **Not Application Code:** No software being built with the protocol

**Analogy:** 
- VIBECONTROL repository is like the HTTP specification repo
- Projects using VIBECONTROL are like websites using HTTP
- We define the protocol; others implement it in their projects

## Two Audiences

### Audience 1: Human Developers

**What They Read:** README.md

**What They Learn:**
- What VIBECONTROL is and why it exists
- Problems it solves (session amnesia, context loss)
- How to install and use it
- Benefits and use cases
- Philosophy and principles

**What They Do:**
- Run install script in their project
- Tell AI assistant to follow VIBECONTROL protocol
- Continue building their project with maintained context

### Audience 2: LLM Assistants

**What They Read:** VIBECONTROL.md (in user's project)

**What They Learn:**
- How to maintain context files
- When to update progress.md
- How to structure plans and knowledge
- Operational procedures for session management
- Error handling and edge cases

**What They Do:**
- Read context at session start
- Update documentation as they work
- Log progress at session end
- Follow protocol deterministically

## Repository Structure

### Core Documentation

**README.md**
- **Audience:** Human developers
- **Purpose:** Marketing, education, getting started
- **Tone:** Persuasive, example-rich, benefit-focused
- **Length:** Comprehensive (~1000+ lines)

**VIBECONTROL.md**
- **Audience:** LLM assistants (via docs/ in user projects)
- **Purpose:** Technical specification, operational procedures
- **Tone:** Precise, deterministic, instruction-focused
- **Length:** Detailed (~1200+ lines)

**CLAUDE.md**
- **Audience:** LLM assistants working on VIBECONTROL itself
- **Purpose:** Guidance for maintaining protocol repository
- **Tone:** Instructive, principle-focused
- **Length:** Moderate (~100-200 lines)

### Supporting Files

**install.sh** (+ install.js, install.py)
- **Purpose:** Automate VIBECONTROL setup in user projects
- **Copies:** VIBECONTROL.md into user's docs/ directory
- **Creates:** docs/ structure with chosen modules

**LICENSE**
- **Purpose:** MIT license for free use
- **Ensures:** No restrictions on commercial use

**USAGE.md** (if present)
- **Purpose:** Detailed usage instructions
- **Supplements:** README.md with deeper examples

### Meta-Dogfooding

**docs/** (in VIBECONTROL repository itself)
- **Purpose:** Demonstrate protocol by using it for VIBECONTROL development
- **Contains:** 
  - docs/VIBECONTROL.md (the protocol we follow)
  - docs/progress.md (our development log)
  - docs/plans/ (protocol development roadmap)
  - docs/knowledge/ (design principles, architecture)

**Why Dogfood:**
- Validates protocol works as designed
- Demonstrates best practices
- Catches usability issues early
- Provides real-world example

## Critical Distinctions

### What This Repository IS

✅ **Protocol Specification**
- Defines how to structure context management
- Instructions for LLM assistants
- Standards and conventions

✅ **Documentation Hub**
- User guides
- Installation instructions
- Philosophy and rationale

✅ **Tooling Collection**
- Installation scripts
- Optional integrations (MCP, etc.)
- Templates and examples

### What This Repository IS NOT

❌ **Not a Software Project Being Built**
- There's no application logic
- No features being implemented for end users
- No production deployment

❌ **Not an Example of VIBECONTROL in Use**
- We use VIBECONTROL to maintain VIBECONTROL (meta-usage)
- Separate example projects should demonstrate typical usage
- This repository's docs/ is about protocol development, not a sample project

❌ **Not a Framework or Library**
- No code to import or require
- No API to call
- No runtime component

❌ **Not a Platform or Service**
- No servers
- No accounts
- No SaaS offering

## Development Implications

### When Making Protocol Changes

**Consider Both Audiences:**
```
Change VIBECONTROL.md → Affects LLM behavior in user projects
Update README.md → Affects developer understanding and adoption
Modify install.sh → Affects new user setup experience
```

**Maintain Consistency:**
- File structure in README must match VIBECONTROL.md spec
- Examples in README must follow VIBECONTROL.md formats
- Terminology consistent across all documentation

**Version Carefully:**
- Breaking changes to protocol → Major version bump (v3.0.0)
- New optional features → Minor version bump (v2.1.0)
- Documentation fixes → Patch version bump (v2.0.1)

### When Adding Features

**Ask:**
1. Does this solve a real context management problem?
2. Does it maintain simplicity and zero dependencies?
3. Is it tool-agnostic and future-proof?
4. Can it be optional (progressive disclosure)?
5. Is it clear to both humans and LLMs?

**If No to Any:** Reconsider or adapt the feature

### When Documenting Work

**Use VIBECONTROL to Maintain VIBECONTROL:**
- Log protocol changes in docs/progress.md
- Plan major features in docs/plans/
- Extract design decisions to docs/knowledge/
- Follow our own protocol to validate it works

**Benefits of Meta-Dogfooding:**
- Immediate feedback on protocol usability
- Real-world testing of instructions
- Documentation demonstrates itself
- Consistency between protocol and practice

## File Relationships

```
README.md
  ├─ Describes: VIBECONTROL protocol benefits
  ├─ References: VIBECONTROL.md for specifications
  └─ Explains: How to use install.sh

VIBECONTROL.md
  ├─ Defines: Protocol structure and procedures
  ├─ Used by: LLM assistants in user projects
  └─ Copied by: install.sh into user's docs/

CLAUDE.md
  ├─ Guides: LLM assistants working on this repository
  ├─ Explains: Meta-repository architecture (references this file)
  └─ Maintains: Protocol development coherence

install.sh
  ├─ Creates: docs/ structure in user project
  ├─ Copies: VIBECONTROL.md into user's docs/
  └─ Initializes: progress.md with starter entry

docs/ (in VIBECONTROL repo)
  ├─ Demonstrates: Protocol by using it for self-maintenance
  ├─ Contains: Development history, plans, knowledge
  └─ Validates: Protocol works in practice
```

## Common Confusion Points

### "Isn't this just good documentation practices?"

**Response:** Yes, but structured specifically for LLM comprehension with deterministic procedures. The protocol ensures consistency across sessions and tools.

### "Why not just tell the LLM what to do?"

**Response:** You can, but:
- Re-explaining every session wastes time
- Different phrasing = inconsistent behavior
- Protocol provides shared vocabulary
- Documentation persists across LLMs and sessions

### "Why call it a protocol?"

**Response:** Because it defines:
- Standard formats (like HTTP defines request/response format)
- Operational procedures (like TCP defines connection lifecycle)
- Interoperability (like SMTP ensures email delivery)
- Versioning and evolution (like API versioning)

### "Isn't this over-engineering?"

**Response:** For simple projects using minimal setup, no. For complex projects with teams or long timespans, under-engineering context management causes problems VIBECONTROL solves.

## Evolution Path

**Today (v2.0.0):**
- Core protocol established
- Basic tooling (install.sh)
- Comprehensive documentation

**Near Future (v2.x):**
- Additional installation scripts (Node.js, Python)
- Example projects demonstrating usage
- Integration guides for tools
- Community feedback incorporated

**Long Term (v3.x+):**
- Protocol refinements based on real-world usage
- Optional advanced modules
- Ecosystem integrations (MCP, VS Code, etc.)
- Potential specialized variants for domains

**Principles Remain Constant:**
- Files over abstractions
- Zero dependencies
- Tool-agnostic
- Human and machine readable

## Related

- See: docs/knowledge/protocol-design-principles.md for design rationale
- See: CLAUDE.md for maintenance guidance
- See: docs/plans/meta-vibecontrol-development.md for roadmap

---
