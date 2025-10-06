# VIBECONTROL

**File-based context management protocol for LLM-assisted development.**

Stop re-explaining your project to AI assistants every session. VIBECONTROL gives LLMs persistent memory through markdown files in your git repository.

---

## What Is This?

VIBECONTROL is a protocol—a set of instructions and file structures—that helps AI assistants maintain project context across sessions. It's not a tool or framework. It's a standardized way to document work so future AI sessions (and humans) understand what's been done and why.

**Core concept:** Use markdown files in `docs/` to track decisions, progress, and knowledge. Your AI assistant reads these at session start and updates them as work progresses.

---

## The Problem It Solves

Working with AI coding assistants (Claude, ChatGPT, Cursor, Copilot):
- Each new session starts from zero context
- Architectural decisions get lost between conversations
- Context limits force you to restart and re-explain
- Different team members' AI assistants make conflicting decisions

**VIBECONTROL provides version-controlled context that persists across sessions, tools, and team members.**

---

## Installation

```bash
# Clone and run the installer
git clone https://github.com/ser-daniel/vibe-control.git
cd vibe-control
./install.sh --standard

# Or download directly
curl -sSL https://raw.githubusercontent.com/ser-daniel/vibe-control/main/install.sh | bash
```

The installer creates a `docs/` directory structure in your project with:
- `VIBECONTROL.md` - Protocol instructions for AI assistants
- `progress.md` - Chronological work log
- `plans/` - Task breakdowns (optional)
- `knowledge/` - Stable reference documentation (optional)

---

## Quick Start

1. **Install VIBECONTROL** in your project (see above)

2. **Tell your AI assistant:**
   ```
   This project uses VIBECONTROL. Read docs/VIBECONTROL.md and follow the protocol.
   ```

3. **Start working:**
   ```
   Let's implement user authentication. Create a plan first.
   ```

Your AI will:
- Create `docs/plans/feature-authentication.md` with task breakdown
- Update `docs/progress.md` as work completes
- Document patterns in `docs/knowledge/`

---

## File Structure

```
docs/
├── VIBECONTROL.md          # Protocol specification (AI instructions)
├── progress.md             # Chronological work log
├── plans/                  # Task breakdowns and roadmaps
├── knowledge/              # Patterns, conventions, architecture
├── schema/                 # Diagrams (Mermaid format)
└── proc/                   # Debug logs, context snapshots
```

**Start minimal** with just `progress.md`, add modules as needed.

---

## How It Works

### For Developers

**Start session:**
- Your AI reads recent `progress.md` and active plans
- You continue from exactly where you left off
- No re-explaining needed

**During work:**
- AI documents decisions as they're made
- Task status updates automatically
- Patterns extracted to `knowledge/`

**End session:**
- AI logs completed work to `progress.md`
- Context preserved for next session

### For AI Assistants

`docs/VIBECONTROL.md` provides explicit instructions:

**At session start:**
1. Read protocol and recent progress
2. Check active tasks
3. Load relevant knowledge
4. Acknowledge current state

**During work:**
1. Document decisions immediately
2. Update task status
3. Extract reusable patterns
4. Create checkpoints if approaching context limits

**Before session end:**
1. Log completed work
2. Update task completion
3. Note next steps

---

## Example: Progress Entry

After implementing authentication:

```markdown
## 2025-10-06 14:30 UTC

### Implemented JWT authentication middleware

**Context:** Need to secure API endpoints

**Changes:**
- Created middleware/auth.js with JWT validation
- Added requireAuth to protected routes
- Set token expiration to 15 minutes
- Tests: 12 passing in tests/auth.test.js

**Outcome:** All /api/admin/* routes now require valid JWT

**Issues:** Need to implement token refresh flow

**Next:** Add refresh token endpoint

**Related:** docs/knowledge/auth-patterns.md
```

---

## Use Cases

- **Solo developers:** Track features across weeks without losing context
- **Teams:** Share architectural decisions across developers and AI assistants
- **Open source:** Document project evolution chronologically
- **Consultants:** Maintain separate context per client project
- **Long-running tasks:** Checkpoint and resume work across multiple sessions

---

## Integration

### Claude Desktop / Cursor / Any IDE

Start your session with:
```
This project uses VIBECONTROL. Read docs/VIBECONTROL.md.
```

### Add to .cursorrules

```
This project uses VIBECONTROL for context management.
- Read docs/VIBECONTROL.md at session start
- Update docs/progress.md after completing work
- Check docs/plans/ for active tasks
```

---

## Key Principles

1. **Files over abstractions** - Everything is markdown
2. **Git-native** - Version control your context like code
3. **LLM-friendly** - Optimized for AI comprehension
4. **Tool-agnostic** - Works with any LLM
5. **Progressive** - Start simple, add complexity when needed
6. **Zero dependencies** - No frameworks, servers, or SaaS

---

## What VIBECONTROL Is

- ✅ A protocol for managing AI context
- ✅ Markdown files in your git repository
- ✅ Instructions for LLM assistants
- ✅ Free and open source

## What VIBECONTROL Is Not

- ❌ A framework with dependencies
- ❌ A SaaS platform
- ❌ Prescriptive or rigid
- ❌ Coupled to specific tools
- ❌ Complex or abstract

---

## Documentation

- **Full protocol specification:** `docs/VIBECONTROL.md`
- **Usage guide:** `USAGE.md`
- **Development guide:** `CLAUDE.md`

---

## Contributing

This is an early-stage open-source project. Contributions welcome:

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

Ideas for contributions:
- Bug fixes and improvements
- Documentation clarifications
- Example projects
- Integration guides
- Templates for different project types

---

## Repository

- GitHub: [ser-daniel/vibe-control](https://github.com/ser-daniel/vibe-control)
- Issues: Report bugs and request features via GitHub Issues

---

## Philosophy

VIBECONTROL emerged from practical frustration with AI context loss. It applies version control semantics to AI memory, using files developers already understand.

**Core insight:** If you track your code with git, why not track your AI's context the same way?

---

**Made by developers who were tired of re-explaining their projects every session.**
