---
name: new-karabiner-rule
description: Use when adding or editing a Karabiner rule in home/karabiner/ (karabiner.ts TypeScript config) — build/dry-run/verify commands, rule registration, shared modules, gotchas.
disable-model-invocation: true
---

# Adding a Karabiner rule

`home/karabiner/` is TypeScript built with `karabiner.ts`. The build writes the **live** `~/.config/karabiner/karabiner.json` — there is no dotbot link. Always `--dry-run` before writing.

## Preflight

```sh
cd home/karabiner && bun index.ts --dry-run   # prints the profile JSON, exit 0
```

- Deps live in `home/karabiner/node_modules`; there is **no `package.json`/`tsconfig.json`** in the tree, so the `npm run build|dry-run|verify` scripts older docs mention don't exist — call bun directly. (If you ever want npm scripts back: `git show d54e444:home/karabiner/package.json`, same for `tsconfig.json`, `bun.lock`, `scripts/tsconfig.json`.)
- `rules/onepassword.ts`, `hyper.ts`, and `scripts/resolve-mac.ts` were dropped from the tree on 2026-09-29: the 1Password-specific rule is intentionally gone (its `onep` app entry lives on in `apps.ts` for `action-dispatch.ts`), `hyperMods` was recreated in `hyper.ts`, and `extractIdentifier` is inlined in `scripts/verify-ids.ts`. Don't re-add imports for deleted files.
- `bun run scripts/verify-ids.ts` must exit 0 with "All checked bundle ids match." before you touch `apps.ts`.

## Adding a rule

1. Create `home/karabiner/rules/<name>.ts`, default-exporting an array of manipulators.
2. Register it in `index.ts`: add the import and splice it into the `writeToProfile(...)` array. **Position matters** — array order becomes Karabiner rule order (first match wins); put it next to related rules.
3. `bun index.ts --dry-run` prints the generated JSON instead of writing, and skips `writeToGlobal()` (guarded explicitly in `index.ts`).
4. Read the printed output, then `bun index.ts` writes the live config. The `fs.writeFile` monkey-patch at the top of `index.ts` serializes and atomically renames writes — keep it; Karabiner's daemon rewrites the same file concurrently.
5. If the rule touches `apps.ts`, run `bun run scripts/verify-ids.ts` to cross-check bundle-id regexes against installed apps (`mdfind`/`mdls`).

## Gotchas

- Shared hyper modifiers are `hyperMods` in `home/karabiner/hyper.ts`, imported by `rules/hammerspoon-ports.ts`, `rules/misc.ts`, and `rules/modifiers.ts` — don't re-declare the array in a rule file.
- Karabiner `shell_command`s run without a login shell (no PATH, no zprofile). Use `withPrivateEnv()` from `private-env.ts` when a command needs credentials/PATH; never inline secrets anywhere in this directory.
- `writeToProfile` only rewrites `profile.simple_modifications` when extras are passed — read the trailing comment in `index.ts` before changing that argument, or stale f10/f11/f12 entries reappear in `karabiner.json`.
