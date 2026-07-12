# AGENTS.md

Guidance for AI coding agents working with this dotfiles repository.

## Installation

```bash
./install          # Bootstrap everything: submodules, symlinks, Homebrew, npm, macOS setup
```

The `install` script wraps [Dotbot](https://github.com/anishathalye/dotbot), which reads `install.conf.yaml` and orchestrates the full setup: creates symlinks from `home/` into `~` and `~/.config/`, installs Homebrew packages from `Brewfile`, runs shell scripts, and sets macOS default app associations via `duti`.

Dotbot plugins live as git submodules in `dotbot-plugins/` (brew, duti). To update submodules: `git submodule update --init --recursive`.

**No tests, no lint, no build.** This repo is configs, not application code. The only "build" is re-running `./install` (idempotent). Lint configs that *live* here (`home/golangci_lint.yml`, `home/luaformatter.yaml`, `home/vale.ini`, etc.) configure other tools — they aren't run from this repo.

## Repository structure

- **`home/`** — All user config files. Dotbot symlinks these into `~` and `~/.config/` per `install.conf.yaml`.
- **`home/zsh/`** — Shell config split by concern: `commands.sh` (aliases/functions), `git.sh` (git helpers), `golang.sh`, `ruby.sh`, `fzf.sh`, `bindkeys.sh`, `overload.sh`, `update.sh`, `zim.sh`, `ysu_ignored.sh`, `_after_zsh.sh` (post-plugin init). Also `bin/` (git helper scripts like `git-outgoing`, `git-sync`, `git-ai-commit`, accessible via `~/.zsh/bin/`) and `misc/` (`thisisfine.sh`, `utility.zsh`).
- **`home/vim/`** — Neovim config (Lua). Entry point: `init.lua` (plus `min_init.lua` minimal bootstrap). Plugins managed via lazy.nvim. Lua modules in `lua/` (mappings, commands, operators, autocommands, utility, folders, neovide). LSP configs in `lsp/` (jsonls, lua_ls, ruby_lsp, yamlls). Plugin specs in `lua/plugins/` (~27 files covering blink-cmp, conform, edgy, flash, fzflua, gitsigns, mini, neotest, snacks, treesitter, which-key, and more). Additional dirs: `after/` (ftplugin, plugin, queries, syntax), `autoload/`, `ftdetect/`, `ftplugin/` (per-filetype Lua), `snippets/`, `spell/`.
- **`home/hammerspoon/`** — macOS automation in Lua. `init.lua` requires `hyper.lua`, `actions.lua`, `layout.lua`, `watchers.lua`, `utils.lua`, then loads Spoons. `watchers.lua` is a manifest that requires sub-watchers in `watchers/` (audio, camera, mqtt, screens, swiftbar). `watchers/screens.lua` is symlinked from iCloud (`~/iCloud/Internal/custom/screens.lua`) since per-machine layout is private. `actions.lua` is data-driven, reading `actions.json`. Helper scripts in `scripts/` (AppleScripts for OmniFocus integration). Spoons in `Spoons/` (Caffeine, FadeLogo, KSheet, SendToOmniFocus, SkyRocket, SpoonInstall).
- **`home/bin/`** — Custom scripts (e.g. `pi-local`). Symlinked to `~/.local/bin/`.
- **`scripts/macos/`** — macOS-only one-shot scripts: Dock setup (`dockutil_init.sh`), folder visibility (`hide_folders.sh`), default app associations (`Dutifile`).
- **`dotbot/`** — Dotbot submodule (core engine).
- **`dotbot-plugins/`** — Dotbot plugin submodules (brew, duti, sudo).

### Notable config files in `home/`

Terminal emulators: `alacritty.toml`, `ghostty`, `wezterm.lua`.
CLI tools: `lazygit.yml`, `lsd.yaml`, `btop.conf`, `atuin.toml`, `ripgreprc`, `batconfig`, `starship.toml`, `agignore` (shared ignore file for fd/rg/bat).
Neovim GUI: `neovide.toml` (config) — the `neovide.lua` Lua module lives at `home/vim/lua/neovide.lua`.
Neovim version manager: `bob.json` (bob config, installs nvim to `home/zsh/bin`).
Other: `irbrc`, `gemrc`, `bundle_config`, `default-gems`, `rspec`, `tidyrc`, `vale.ini`, `golangci_lint.yml`, `luaformatter.yaml`, `ctags`, `gitconfig`, `gitignore_global`, `gitmessage`, `karabiner.js`, `debug_off_env`.

## Key architecture notes

**Private config via iCloud:** SSH keys, GPG, work gitconfig, and other secrets live at `~/iCloud/Internal/private/` (outside this repo). Dotbot symlinks `~/.zsh/private` → that path on macOS at install time; the symlink isn't committed and won't appear in `git ls-files`. Additional private symlinks: `~/.ssh`, `~/.gnupg`, `~/.gitconfig.local`, `~/.agents`, `~/.claude`, `~/.config/opencode`.

**`$DOTFILES` env var is load-bearing.** `home/zprofile` exports `DOTFILES=$HOME/code/dotfiles`, and `zshrc` sources every split file via `$DOTFILES/home/zsh/...`. Other key exports set there: `HOME_DIR` (points to `$DOTFILES/home`), `NAVI_PATH` (points to `$DOTFILES/home/doc`), and `HOMEBREW_BUNDLE_FILE_PATH` (pinned to this repo's Brewfile so ad-hoc `brew bundle` uses it). Additional private exports live in `home/zsh/private/private.zsh` (sourced from iCloud, not committed).

**Zsh loading order:** `zprofile` (login, PATH/exports) → `zshrc` sources `commands.sh`, `git.sh`, etc. unconditionally, then sources Zim and remaining plugins only in interactive TTY sessions (`[[ -t 0 ]] && [[ -t 1 ]]`).

**Neovim plugin manager:** lazy.nvim is bootstrapped in `init.lua` if not present. Plugins are declared in `lua/plugins/` (~27 plugin spec files). The config disables several built-in nvim plugins for performance. LSP server configs in `lsp/` cover jsonls, lua_ls, ruby_lsp, yamlls. Neovide GUI config in `lua/neovide.lua` and `neovide.toml`.

**Neovim version management:** `bob` manages Neovim versions (config at `home/bob.json`), installing to `home/zsh/bin`. `mise` manages other language versions, activated last in `zshrc` to override PATH.

**Conditional symlinks:** macOS-only items (Hammerspoon, Karabiner, SSH, GPG, iCloud, Obsidian Vaults, private agent configs) use `if: "[ \`uname\` = Darwin ]"` guards in `install.conf.yaml`.

**Composite Brewfile:** `install.conf.yaml` runs `brewfile` against this repo's `Brewfile`. The Brewfile is extensive: ~50 brew formulae, ~50 casks, ~35 mas (Mac App Store) apps, plus cargo, go, and npm packages.

**Hammerspoon Hyper key + actions:** `init.lua` defines a global `Hyper = { "cmd", "alt", "ctrl", "shift" }` used by every binding. `actions.lua` is data-driven: it reads `actions.json` and dispatches per-app `keystroke` or `menu` entries based on the frontmost app. To add app-specific behavior, edit the JSON, not the Lua. `layout.lua` handles monitor/window layout. `utils.lua` provides shared helpers. Spoons are installed via `SpoonInstall` from a custom fork repo (`garymh/Spoons`) registered in `init.lua`.

**Obsidian Vaults:** Dotbot symlinks `~/Vaults` → `~/Library/Mobile Documents/iCloud~md~obsidian/Documents` on macOS.

**`.gitignore`** excludes: `.DS_Store`, `**/.DS_Store`, `/home/zsh/private/*` (except `.keep`), `/home/zsh/bundle/*`, `*.zwc`, `/home/hammerspoon/Spoons`, `.lsp`, `.clj-kondo`, `vim_bugs.md`.

**`.pi/extensions/`** directory for Pi coding agent extensions.

**Lua globals:** `.luarc.json` (at repo root) declares globals for Neovim/Hammerspoon development (`vim`, `hs`, `spoon`, mapping helpers `nmap`/`vmap`/`cmap`/etc., `Augroup`, `Nv9`/`Nv10` version guards, `icons`, `tools`).
