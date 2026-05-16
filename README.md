# yanctab Marketplace

A Claude Code plugin marketplace hosting tools and workflows for development.

## Available Plugins

- **ywflow** — Repeatable, deterministic development workflow for new projects via a Makefile contract
  - Stable version from GitHub
- **ywflow-dev** — Local development version of ywflow
  - Use during development with local source code

## Installation

### Add the marketplace

In Claude Code, run:

```
/plugin marketplace add yanctab/yanctab-claude-marketplace
```

### Install a plugin

Once the marketplace is added, install plugins with:

```
/plugin install ywflow@yanctab-marketplace
```

Then reload plugins to pick up the changes:

```
/reload-plugins
```

### Development Installation (Local)

To test local changes to ywflow during development:

1. Clone both repos to the same parent directory:
   ```bash
   git clone https://github.com/yanctab/yanctab-claude-marketplace.git
   git clone https://github.com/yanctab/ywflow-claude-plugin.git
   ```

2. In Claude Code, add the local marketplace:
   ```
   /plugin marketplace add /path/to/yanctab-claude-marketplace
   ```

3. Install the development version:
   ```
   /plugin install ywflow-dev@yanctab-marketplace
   /reload-plugins
   ```

Now you can edit the local ywflow-claude-plugin and reload plugins to test changes:

```
/reload-plugins
```

**Note:** The `ywflow-dev` entry uses a relative path (`../ywflow-claude-plugin`), so both repos must be siblings in the same parent directory.

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
