# yanctab Marketplace

A Claude Code plugin marketplace hosting tools and workflows for development.

## Available Plugins

- **ywflow** — Repeatable, deterministic development workflow for new projects via a Makefile contract
  - Stable version from GitHub
- **ywflow-dev** — Local development version of ywflow
  - Use during development with local source code

## Installation

### Official Installation (Stable Version)

For users who want the stable, released version of plugins:

**Step 1: Add the marketplace**

In Claude Code, run:

```
/plugin marketplace add yanctab/yanctab-claude-marketplace
```

**Step 2: Install a plugin**

Once the marketplace is added, install plugins with:

```
/plugin install ywflow@yanctab-marketplace
```

**Step 3: Reload plugins**

Then reload plugins to pick up the changes:

```
/reload-plugins
```

You'll now have the latest stable version of ywflow installed. To receive updates when new versions are released:

```
/plugin marketplace update yanctab-marketplace
/reload-plugins
```

---

### Local Development Installation

For developers who want to test local changes across multiple sessions:

**Directory Structure**

Clone both repos to the same parent directory:

```bash
workspace/
├── yanctab-claude-marketplace/
└── ywflow-claude-plugin/
```

This allows the marketplace to find the plugin via relative path.

**Step 1: Clone the repositories**

```bash
cd ~/workspace
git clone https://github.com/yanctab/yanctab-claude-marketplace.git
git clone https://github.com/yanctab/ywflow-claude-plugin.git
```

**Step 2: Add the local marketplace**

In Claude Code, run:

```
/plugin marketplace add /path/to/yanctab-claude-marketplace
```

Note: Use the absolute path to your local marketplace directory, not the GitHub URL.

**Step 3: Install the development version**

```
/plugin install ywflow-dev@yanctab-marketplace
/reload-plugins
```

**Step 4: Test local changes**

Now when you edit files in `ywflow-claude-plugin`, simply reload plugins:

```
/reload-plugins
```

Changes are picked up immediately in the same session and persist across sessions.

---

### Comparison: Official vs Local Development

| Aspect | Official (ywflow) | Development (ywflow-dev) |
|--------|-------------------|--------------------------|
| **Source** | GitHub (released versions) | Local directory |
| **Version** | Fixed (v2.0.0, v2.0.1, etc.) | Always latest commits |
| **Updates** | Manual (`/plugin marketplace update`) | Automatic on reload |
| **Use Case** | End users, stable releases | Plugin developers, testing |
| **Setup** | Simple: add marketplace, install | Requires cloned repos as siblings |
| **Directory Structure** | Not required | Both repos in same parent |

---

### Workflow Summary

**If you're a user:** Use `ywflow@yanctab-marketplace`
- Install once
- Receive stable updates
- No setup beyond marketplace add

**If you're a plugin developer:** Use `ywflow-dev@yanctab-marketplace`
- Clone both repos locally
- Changes are picked up on each `/reload-plugins`
- Perfect for testing new features before release

### Usage

After installation, you can use the plugin's skills. For example:

```
/ywflow:execute <issue-number>
/ywflow:init-project
/ywflow:planning-session
```

Run `/help` to see all available skills from the ywflow plugin.

## About yanctab Marketplace

This marketplace provides Claude Code with development workflow tools built around a Makefile contract. Each plugin follows standard project conventions for building, testing, linting, and releasing.

## Managing Plugins

### Update all plugins

To update plugins in this marketplace to their latest versions:

```
/plugin marketplace update yanctab-marketplace
```

Then reload plugins:

```
/reload-plugins
```

### View installed plugins

```
/plugin list
```

## Adding New Plugins

To add a new plugin to this marketplace:

1. Create the plugin in its own repository (e.g., `https://github.com/yanctab/my-plugin`)
2. Ensure it has a `.claude-plugin/plugin.json` manifest
3. Add an entry to `.claude-plugin/marketplace.json`:

```json
{
  "name": "my-plugin",
  "description": "Description of the plugin",
  "source": {
    "source": "github",
    "repo": "yanctab/my-plugin"
  },
  "version": "1.0.0"
}
```

4. Push the changes to this repository

## Support

For issues or questions about plugins in this marketplace, visit the individual plugin repositories or create an issue in this repository.

## License

Each plugin in this marketplace has its own license. See individual plugin repositories for details.
