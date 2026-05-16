# yanctab Marketplace

A Claude Code plugin marketplace hosting tools and workflows for development.

## Available Plugins

- **[ywflow](https://github.com/yanctab/ywflow-claude-plugin)** — Repeatable, deterministic development workflow for new projects via a Makefile contract
- **ywflow-dev** — Local development version of ywflow (for plugin developers)

## Installation

### Official Installation (Stable Version)

Add the marketplace to Claude Code:

```
/plugin marketplace add yanctab/yanctab-claude-marketplace
```

Then install a plugin:

```
/plugin install <plugin-name>@yanctab-marketplace
/reload-plugins
```

To receive updates when new versions are released:

```
/plugin marketplace update yanctab-marketplace
/reload-plugins
```

### Local Development Installation

For plugin developers: if a plugin offers a `-dev` variant, you can install the development version to test local changes across multiple sessions.

Clone both the marketplace and plugin repos as siblings:

```bash
workspace/
├── yanctab-marketplace/
└── <plugin-name>/
```

Then add the local marketplace:

```
/plugin marketplace add /path/to/yanctab-marketplace
/plugin install <plugin-name>-dev@yanctab-marketplace
/reload-plugins
```

Now edits to the local plugin are picked up on each `/reload-plugins`.

**Example:** For ywflow development:
```
/plugin install ywflow-dev@yanctab-marketplace
```

## Adding New Plugins

To add a new plugin to this marketplace:

1. Create the plugin in its own repository
2. Ensure it has a `.claude-plugin/plugin.json` manifest
3. Add entries to `.claude-plugin/marketplace.json`:

**Official/Stable Version:**

```json
{
  "name": "plugin-name",
  "description": "Brief description of the plugin",
  "source": {
    "source": "github",
    "repo": "yanctab/plugin-name",
    "ref": "v1.0.0"
  },
  "version": "1.0.0",
  "author": {
    "name": "yanctab"
  },
  "category": "development",
  "license": "MIT"
}
```

**Local Development Version (Optional):**

```json
{
  "name": "plugin-name-dev",
  "description": "plugin-name - local development version (tracks latest commits)",
  "source": "../plugin-name",
  "author": {
    "name": "yanctab"
  },
  "category": "development",
  "license": "MIT"
}
```

Both entries go in the `plugins` array in `.claude-plugin/marketplace.json`.

4. Push the changes to this repository

## About This Marketplace

This marketplace aggregates Claude Code plugins built by yanctab. Each plugin has its own repository with complete documentation, issues, and contribution guidelines.

Visit individual plugin repositories for:
- Detailed installation instructions
- Feature documentation
- Usage examples
- Troubleshooting and support

## License

Each plugin in this marketplace has its own license. See individual plugin repositories for details.

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
