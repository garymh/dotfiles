---
name: nvim-config-change
description: Use when editing the Neovim config under home/vim/ (lazy.nvim plugin specs, LSP server configs, mappings, autocommands) — layout conventions plus the mandatory headless smoke test.
---

# Editing the Neovim config

The config is live: `install.conf.yaml` links `~/.config/nvim/init.lua` and every child of `home/vim/*` into `~/.config/nvim/`, so edits take effect on the next nvim start. No build step.

## Where things go

- `home/vim/init.lua` — entry point: bootstraps lazy.nvim, version guards, disables built-ins for perf. `min_init.lua` is a minimal bootstrap; leave it alone unless asked.
- `home/vim/lua/plugins/<feature>.lua` — one lazy.nvim spec per feature file. Specs use `keys` / `event` / `cmd` for lazy-loading and the `M.config` pattern for setup functions; spec tables are column-aligned. Add a new file rather than growing `misc.lua`, unless the plugin is genuinely miscellaneous.
- `home/vim/lsp/<server>.lua` — LSP server configs (`harper_ls`, `jsonls`, `lua_ls`, `ruby_lsp`, `yamlls`).
- `home/vim/lua/` — `mappings.lua` (grouped in themed sections), `commands.lua`, `autocommands.lua`, `utility.lua`, operators, folders, `neovide.lua`.
- `home/vim/after/`, `ftplugin/`, `ftdetect/`, `snippets/`, `spell/` — filetype-specific behaviour.
- LSP/language globals (`vim`, mapping helpers, `User`, `icons`, …) are declared in the repo-root `.luarc.json` — add new globals there, not inline in Lua.
- Never touch caches/scratch: `.lsp/`, `.ruby-lsp/`, `vim_bugs.md`.

## Conventions

- Lazy-load by `event`/`keys`/`cmd` where possible (see `perf(vim): lazy-load plugins` history).
- Prefer current Neovim APIs (e.g. `vim.lsp.codelens.enable`) over deprecated ones; the config tracks 0.13 compatibility.
- Formatting is Conform on `BufWritePre` (`conform.lua`); don't hand-reformat files to a different style.

## Verify (mandatory, ~0.1 s)

`nvim --headless` exits 0 even when Lua throws — you must grep stderr for `Error in command line`.

```sh
f=home/vim/lua/plugins/misc.lua   # touched file
out=$(nvim --headless "+lua assert(loadfile('$f'))" +qa 2>&1)
case "$out" in *"Error in command line"*) echo "$out"; exit 1;; esac

nvim --headless +qa               # full startup smoke (loads init.lua + lazy.nvim)
```

`loadfile` only compiles a file (no execution) — use it for spec/`lua/` changes. If `init.lua`, top-level spec code, or `lazy` setup changed, run the startup smoke too.
