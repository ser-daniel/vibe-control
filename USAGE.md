# VIBECONTROL Quick Usage Guide

## Installation Commands

### Local Installation

```bash
# Clone or download the repository first
git clone https://github.com/ser-daniel/vibecontrol.git
cd vibecontrol

# Run the installer
./install.sh --standard

# Or from your project directory
bash /path/to/vibecontrol/install.sh --standard
```

### Remote Installation (One-Liner)

```bash
# Standard setup
curl -sSL https://raw.githubusercontent.com/ser-daniel/vibecontrol/main/install.sh | bash -s -- --standard

# Minimal setup
curl -sSL https://raw.githubusercontent.com/ser-daniel/vibecontrol/main/install.sh | bash -s -- --minimal

# Full setup
curl -sSL https://raw.githubusercontent.com/ser-daniel/vibecontrol/main/install.sh | bash -s -- --full
```

## Setup Options

### 1. Minimal (Solo Projects)
```bash
./install.sh --minimal
```
Creates:
- `docs/VIBECONTROL.md` - Protocol
- `docs/progress.md` - Work log

Best for: Personal projects, quick prototypes, single-developer work

### 2. Standard (Recommended)
```bash
./install.sh --standard
```
Creates:
- `docs/VIBECONTROL.md` - Protocol
- `docs/progress.md` - Work log
- `docs/plans/` - Task breakdowns
- `docs/knowledge/` - Reference material

Best for: Most projects, team collaboration, ongoing development

### 3. Full (Complex Projects)
```bash
./install.sh --full
```
Creates:
- `docs/VIBECONTROL.md` - Protocol
- `docs/progress.md` - Work log
- `docs/plans/` - Task breakdowns
- `docs/knowledge/` - Reference material
- `docs/schema/` - Architecture diagrams
- `docs/proc/` - Debug logs and snapshots

Best for: Large projects, enterprise, complex architectures

### 4. Custom (Interactive)
```bash
./install.sh --custom
```
Prompts you to select specific modules interactively.

## First Session with AI

After installation, start your AI conversation with:

```
This project uses VIBECONTROL for context management.
Please read docs/VIBECONTROL.md and follow the protocol.
```

Your AI will:
1. Read the protocol instructions
2. Check recent progress entries
3. Understand current project state
4. Maintain documentation as it works

## Common Workflows

### Starting a New Feature
```
Let's implement user authentication.
Create a plan in docs/plans/ first.
```

### Continuing Previous Work
```
Continue working on the authentication feature
from docs/plans/feature-authentication.md
```

### Debugging an Issue
```
Debug the payment processing timeout.
Document your investigation in docs/proc/
```

### Documenting a Pattern
```
We've discovered a useful error handling pattern.
Add it to docs/knowledge/error-handling.md
```

## Project Integration

### Add to .cursorrules (Cursor IDE)
```
# Context Management
This project uses VIBECONTROL for context management.
- Always read docs/VIBECONTROL.md at session start
- Update docs/progress.md after completing work
- Check docs/plans/ for active tasks
```

### Add to .aider.conf.yml (Aider)
```yaml
# VIBECONTROL integration
read:
  - docs/VIBECONTROL.md
  - docs/progress.md
```

### Add to copilot-instructions.md (GitHub Copilot)
```markdown
## Context Management

This project uses VIBECONTROL. Before suggesting changes:
1. Check docs/progress.md for recent work
2. Review docs/knowledge/ for patterns
3. Follow conventions in docs/VIBECONTROL.md
```

## Maintenance

### Update Protocol
```bash
curl -o docs/VIBECONTROL.md \
  https://raw.githubusercontent.com/ser-daniel/vibecontrol/main/VIBECONTROL.md
```

### Archive Old Progress
```bash
# Move old entries to archive
mv docs/progress.md docs/proc/progress-archive-2025-01.md
touch docs/progress.md
```

### Clean Debug Logs
```bash
# Remove old debugging sessions
find docs/proc/ -type f -name "debug-*.md" -mtime +90 -delete
```

## Directory Structure Reference

```
your-project/
├── docs/
│   ├── VIBECONTROL.md          # Protocol specification
│   ├── progress.md             # Chronological work log
│   ├── plans/                  # Task breakdowns
│   │   ├── feature-auth.md
│   │   └── refactor-api.md
│   ├── knowledge/              # Reference material
│   │   ├── api-patterns.md
│   │   └── auth-flow.md
│   ├── schema/                 # Architecture diagrams
│   │   └── system-architecture.mmd
│   └── proc/                   # Process logs
│       ├── debug-2025-01-15.md
│       └── context-snapshot.md
├── src/                        # Your application code
├── CLAUDE.md                   # Claude Code instructions
├── README.md                   # Project documentation
└── .gitignore
```

## Tips

### For Solo Developers
- Use `--minimal` or `--standard`
- Focus on `progress.md` as your memory
- Create `plans/` only for complex features
- Keep it simple, add complexity as needed

### For Teams
- Use `--standard` or `--full`
- Assign tasks in `plans/` to team members
- Use `knowledge/` as shared documentation
- Commit all docs/ files to git
- Review progress.md in standups

### For Large Projects
- Use `--full` setup
- Maintain `schema/` diagrams for architecture
- Use `proc/` for debugging and investigation
- Archive `progress.md` monthly
- Create indexes in `knowledge/` for discoverability

### For Consultants
- Install per client project
- Use `plans/` to track deliverables
- `knowledge/` becomes handoff documentation
- `progress.md` becomes project journal
- Archive everything at project end

## Help & Support

- Full docs: `docs/VIBECONTROL.md`
- Repository: https://github.com/ser-daniel/vibecontrol
- Issues: https://github.com/ser-daniel/vibecontrol/issues
- Discussions: https://github.com/ser-daniel/vibecontrol/discussions

## Quick Reference

| Command | Purpose |
|---------|---------|
| `./install.sh --help` | Show help message |
| `./install.sh --minimal` | Minimal setup |
| `./install.sh --standard` | Standard setup (recommended) |
| `./install.sh --full` | Full setup |
| `./install.sh --custom` | Interactive module selection |
