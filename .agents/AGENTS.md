# AGENTS.md

Guidance for AI coding agents working with this dotfiles repository.

## Installation

```bash
./install          # Bootstrap everything: submodules, symlinks, Homebrew, npm, macOS setup
```

`install` is a thin bash wrapper around [Dotbot](https://github.com/anishathalye/dotbot). It syncs/updates the `dotbot` submodule, caches sudo up front (`sudo -v` plus a 60s keepalive loop, so the `shell:` steps never prompt mid-run), then runs `dotbot/bin/dotbot -d . -c install.conf.yaml "$@"` — extra arguments are forwarded (e.g. `./install --only=link`).

`install.conf.yaml` is the single source of truth for what lands where:

- **`defaults`** — link ops `create`/`relink`/`force`/`backup` plus `relative: true`; `clean` runs over `~` and `~/.config`, so links removed from the config are pruned on the next run (and conflicting files are backed up).
- **`link`** — `home/…` → `~` / `~/.config/…`. Most entries are single files, and that mapping exists *only* here (`home/lazygit.yml` → `~/.config/lazygit/config.yml`, `home/agignore` → `~/.rgignore` + `~/.fdignore` + `~/.ignore`). Two exceptions: `~/.zsh` links the whole `home/zsh/` directory, and `~/.config/nvim/` links every child of `home/vim/*` via `glob: true`.
- **`install-brew` + `brewfile`** — installs Homebrew if missing, then runs `brew bundle` against this repo's `Brewfile`.
- **`shell`** — `touch ~/.hushlogin`, `touch ~/.rm_recycle`, `scripts/macos/dockutil_init.sh`, `scripts/macos/hide_folders.sh`, SSH dir/key permission fixes.
- **`duti`** — default app associations from `scripts/macos/Dutifile`.

Dotbot plugins are git submodules in `dotbot-plugins/`: `dotbot-brew` (third-party; supplies the `brew`/`brewfile` directives) and `dotbot-duti` (supplies `duti`). Update with `git submodule update --init --recursive`.

**No tests, no lint, no application code.** The only "builds" are re-running `./install` (idempotent), `home/karabiner` (`npm run build` — rewrites Karabiner's live config) and `home/hammerspoon` (`npm run bundle` — esbuild). Lint configs that *live* here (`home/luaformatter.yaml`, `home/vale.ini`) configure other tools — they aren't run from this repo.

## Repository structure

- **`home/`** — All user config files, symlinked into `~` and `~/.config/` per `install.conf.yaml`.
- **`home/zsh/`** — Shell config split by concern: `commands.sh` (aliases/functions), `git.sh` (git helpers), `golang.sh`, `ruby.sh`, `fzf.sh`, `bindkeys.sh`, `overload.sh`, `update.sh`, `zim.sh`, `ysu_ignored.sh`, `_after_zsh.sh` (post-plugin init). Also `bin/` (git helper scripts like `git-outgoing`, `git-sync`, `git-ai-commit`, accessible via `~/.zsh/bin/`) and `misc/` (`thisisfine.sh`, `utility.zsh` — shared helpers `_exists`/`_dir_exists`/`e_success`, sourced first from `zprofile`). `home/zsh/private` is a symlink to iCloud (see below).
- **`home/vim/`** — Neovim config (Lua). Entry point: `init.lua` (plus `min_init.lua` minimal bootstrap). Plugins managed via lazy.nvim. Lua modules in `lua/` (mappings, commands, operators, autocommands, utility, folders, neovide). LSP configs in `lsp/`: `harper_ls`, `jsonls`, `lua_ls`, `ruby_lsp`, `yamlls`. Plugin specs in `lua/plugins/` (24 files: blink-cmp, bufferline, colors, conform, debugprint, flash, fzflua, gitsigns, golang, gui, markdown, mason_lsp, mini, misc, neotest, other, sideways, snacks, splitjoin, surround, switch, todo-comments, treesitter-like, which-key). Additional dirs: `after/` (ftplugin, plugin, queries, syntax), `autoload/`, `ftdetect/`, `ftplugin/` (per-filetype Lua), `snippets/`, `spell/`. `vim_bugs.md` is gitignored scratch.
- **`home/hammerspoon/`** — Hammerspoon 2 (JavaScript) automation, symlinked to `~/.config/Hammerspoon2`. `init.js` starts `hs.ipc`, requires `utils.js`, `caffeine.js`, `layout.js`, `watchers.js`, `send-to-omnifocus.js`, then registers the Safari/Mail AppleScript handlers. `watchers.js` is a manifest that requires sub-watchers in `watchers/` (audio, camera, mqtt, screens, swiftbar). `watchers/screens.js` is symlinked from iCloud (`~/iCloud/Internal/custom/screens.js`) since per-machine layout is private. `scripts/` holds `{safari,mail,outlook,evernote}-to-omnifocus.applescript`, `chrome-to-omnifocus.tpl` (template), the shared `of_library.scpt`, and a README noting their third-party origins. `package.json` + `bundle.js` bundle npm dependencies with esbuild into `lib/` for `require()` (dependencies currently empty; `lib/` is not gitignored, `node_modules/` is).
- **`home/karabiner/`** — Karabiner-Elements config as TypeScript, built with `karabiner.ts`. `index.ts` is the entry point; `rules/` has one file per feature (16: action-dispatch, action-key, browsers, f15-actions, ghostty, hammerspoon-ports, mail, media-keys, misc, modifiers, moom, omnifocus, onepassword, pikatea, terminal, vim-arrows); support files are `apps.ts`, `devices.ts`, `applescripts.ts`, `hyper.ts`, `private-env.ts`, plus `scripts/` (`resolve-mac.ts`, `verify-ids.ts`). No dotbot link — building writes Karabiner's live config directly (see architecture notes).
- **`home/bin/`** — Custom scripts, symlinked to `~/.local/bin/`: `pi-local` (starts a local llama.cpp `llama-server` in a tmux session, waits for it, then execs `pi`) and `alfred-fonts` (Alfred Script Filter over a font-family list, renders cached "Aa" thumbnails with Pillow).
- **`scripts/macos/`** — macOS-only one-shot scripts: Dock setup (`dockutil_init.sh`), folder visibility (`hide_folders.sh`), default app associations (`Dutifile`), plus `macos`/`macos_modern`.
- **`dotbot/`** — Dotbot submodule (core engine).
- **`dotbot-plugins/`** — Dotbot plugin submodules (brew, duti).

### Repo root (`home/` is not the whole story)

- `install` + `install.conf.yaml` — bootstrap entry point and link/directive map.
- `Brewfile` — the package manifest; `Brewfile.lock.json` is generated by `brew bundle` and gitignored.
- `Gemfile` / `Gemfile.lock` — Ruby dev gems for this checkout (`neovim`, `pry-rails`, `amazing_print`, `ripper-tags`, `irb-autosuggestions`, `gem-browse`); `.ruby-lsp/` is ruby-lsp's cache, and `.bundle/config` (gitignored, via the global excludesfile) sets `BUNDLE_WITHOUT=production`.
- `fonts.txt` — one font family per line, consumed by `home/bin/alfred-fonts` (a ghostty config also works as the list).
- `.luarc.json` — Lua language server globals for this repo's nvim config.
- `.projections.json` — editor alt-file mapping (`home/zshrc` ↔ `home/zshenv`; note `home/zshenv` doesn't exist — the `ezshenv`/`zshenv` aliases point at `home/zprofile`).
- `.gitignore`, `.gitmodules`, `README.md`, `LICENSE`.
- `.agents/AGENTS.md` — this file. `.claude/` — repo-local Claude Code settings (ignored via the global excludesfile, see below).

### Notable config files in `home/`

Terminal emulators: `alacritty.toml`, `ghostty` (extension-less config file), `wezterm.lua`.
Shell/prompt: `zprofile`, `zshrc`, `zimrc` (→ `~/.zimrc`), `starship.toml`, `zsh/`.
CLI tools: `lazygit.yml`, `lsd.yaml`, `btop.conf`, `atuin.toml`, `ripgreprc`, `batconfig`, `agignore` (shared ignore file for fd/rg/bat).
Neovim GUI/version manager: `neovide.toml` (config) — the `neovide.lua` Lua module lives at `home/vim/lua/neovide.lua`; `bob.json`.
Ruby: `irbrc`, `gemrc`, `bundle_config` (→ `~/.bundle/config`), `rspec`.
Other: `tidyrc`, `vale.ini`, `luaformatter.yaml`, `ctags`, `gitconfig`, `gitignore_global`, `gitmessage`.

## Key architecture notes

**Private config via iCloud:** SSH keys, GPG, work gitconfig, and other secrets live at `~/iCloud/Internal/private/` (outside this repo). Dotbot symlinks `home/zsh/private` → that path on macOS at install time; the symlink isn't committed and won't appear in `git ls-files` (only `.keep` is kept, via a `.gitignore` exception). Additional private symlinks: `~/.ssh` (`…/private/ssh`), `~/.gnupg` (`…/private/gnupg`), `~/.gitconfig.local`, `~/.agents` (`…/private/agents/`), `~/.claude` (`…/private/claude/`), `~/.config/opencode`, `~/.omp/agent/config.yml`.

**Global gitignore doubles as repo policy:** `home/gitconfig` sets `core.excludesfile = ~/code/dotfiles/home/gitignore_global`, so that file (installed at `~/.gitignore_global`) applies to every repo on the machine. Patterns like `.claude`, `/.bundle/`, `Gemfile.local`, `sandboxes`, `logs` are therefore ignored here *without* appearing in this repo's `.gitignore` — check it before assuming an untracked file should be added.

**`$DOTFILES` env var is load-bearing.** `home/zprofile` exports `DOTFILES=$HOME/code/dotfiles`, and `zshrc` sources every split file via `$DOTFILES/home/zsh/...`. Other key exports set there: `HOME_DIR` (`$DOTFILES/home`), `HOMEBREW_BUNDLE_FILE_PATH` (pinned to this repo's Brewfile so ad-hoc `brew bundle` uses it), `PRIVATE_FILE` (`~/.zsh/private/private.zsh`), `BOB_CONFIG` (`~/.config/bob/config.json`), `XDG_CONFIG_HOME`, `NAVI_PATH` (points at `$DOTFILES/home/doc`, which is not present in this checkout). PATH is rebuilt in a guarded `for d (...)` loop (`_dir_exists`) — only existing dirs are prepended, including `~/.local/share/bob/nvim-bin`, `$HOME_DIR/zsh/bin`, `~/.local/bin`, `~/go/bin`, `~/.opencode/bin`.

**Zsh loading order:** `zprofile` (login) sources `misc/utility.zsh`, exports, the guarded PATH loop, then every `~/.zsh/private/*.zsh`. `zshrc` always sources `commands.sh`, `git.sh`, `golang.sh`, `update.sh`, `overload.sh` (plus `ruby.sh` when `ruby` exists) and sets history options; only in interactive TTY sessions (`[[ -t 0 ]] && [[ -t 1 ]]`) does it continue with `ysu_ignored.sh` → `zim.sh` → `fzf.sh` → `bindkeys.sh` → `_after_zsh.sh`, plus carapace/vivid completion caches under `~/.cache/zsh` and the OrbStack init. `zim.sh` self-bootstraps zimfw into `~/.zim` and generates `~/.zim/init.zsh` from the linked `~/.zimrc`.

**Neovim plugin manager:** lazy.nvim is bootstrapped in `init.lua` if not present. Plugins are declared in `lua/plugins/` (24 spec files). The config disables several built-in nvim plugins for performance. LSP server configs in `lsp/` cover harper_ls, jsonls, lua_ls, ruby_lsp, yamlls. Neovide GUI config in `lua/neovide.lua` and `neovide.toml`.

**Neovim version management:** `bob` manages Neovim versions (config at `home/bob.json`, which sets `add_neovim_binary_to_path: false`); `zprofile` adds bob's install dir `~/.local/share/bob/nvim-bin` to PATH itself. The config pins `downloads_location` to `$HOME/.local/share/bob` because macOS's default bob data dir (`~/Library/Application Support/bob`) contains a space, which breaks neovim's Makefile when `enable_release_build` compiles nightly from source (unquoted `$(MAKEFILE_DIR)` in the `.ran-deps-cmake` recipe).

**Karabiner config pipeline:** `cd home/karabiner && npm install` (devDeps: `karabiner.ts`, `tsx`, `zod`; bun used for `verify`). `npm run build` = `tsx index.ts` → writes profile `New Goku` into Karabiner-Elements' live `~/.config/karabiner/karabiner.json`; `npm run dry-run` prints instead and also skips the `writeToGlobal()` call. `index.ts` monkey-patches `fs.writeFile` to serialize same-path writes and rename atomically, because `karabiner.ts` fires unawaited writes that race the Karabiner daemon's own rewrites. `npm run verify` = `bun run scripts/verify-ids.ts`, cross-checking `apps.ts` bundle-id regexes against installed apps via `mdfind` (`scripts/resolve-mac.ts`). Karabiner `shell_command`s run without a login shell, so anything needing secrets/PATH must go through `private-env.ts`'s `withPrivateEnv()`, which sources `$HOME/.zsh/private/private.zsh` (= `$PRIVATE_FILE`); see `rules/pikatea.ts`.

**Conditional symlinks:** macOS-only items use `if: "[ \`uname\` = Darwin ]"` guards in `install.conf.yaml`: `~/iCloud`, `~/Vaults`, `home/zsh/private`, `~/.ssh`, `~/.gnupg`, `~/.gitconfig.local`, `~/.agents`, `~/.claude`, `~/.config/opencode`, `~/.omp/agent/config.yml`, `~/.config/Hammerspoon2` (+ its `watchers/screens.js`). Karabiner has no link at all — its config is generated in place.

**Brewfile size:** `Brewfile` declares 5 taps, 71 formulae, 56 casks, 43 `mas` (Mac App Store) apps, plus 1 cargo, 1 go, and 4 npm packages.

**Hammerspoon 2 (JS) automation:** HS2's `require()` wraps each module in an IIFE, so modules share helpers through `globalThis` (e.g. `globalThis.isDocked` in `utils.js`), and `hs.urlevent` handlers must be pinned to `globalThis` or the JSFunction is garbage-collected within ~60–90s. Stateful actions are URL-dispatched from Karabiner: `hammerspoon2://layout?name=…` (window/Moom layout plus caffeine state) and `hammerspoon2://omnifocus` (per-app OmniFocus AppleScript chain). Hyper-key keystroke/media bindings live entirely in Karabiner (`home/karabiner/rules/hammerspoon-ports.ts`, `rules/media-keys.ts`). `caffeine.js` toggles display-sleep prevention from a menubar item, using the `caffeine-on.pdf`/`caffeine-off.pdf` icons in its directory.

**Obsidian Vaults:** Dotbot symlinks `~/Vaults` → `~/Library/Mobile Documents/iCloud~md~obsidian/Documents` on macOS.

**`.gitignore`** (repo-local) excludes: `.DS_Store`, `**/.DS_Store`, `/home/zsh/private/*` (except `.keep`), `/home/zsh/bundle/*`, `*.zwc`, `/home/hammerspoon/node_modules`, `.lsp`, `Brewfile.lock.json`, `.clj-kondo`, `vim_bugs.md`.

**Lua globals:** `.luarc.json` (at repo root) declares globals for Neovim development (`vim`, mapping helpers `nmap`/`vmap`/`xmap`/`omap`/`cmap`/`nxmap` plus the `s_*` variants, `Augroup`, `Nv9`/`Nv10` version guards, `icons`, `tools`, `User`).
