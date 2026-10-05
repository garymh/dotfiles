---
name: agents-md-sync
description: Use after structural repo changes (files added/moved/removed, workflows changed) to detect drift between the checkout and .agents/AGENTS.md and propose a minimal patch. Read-only.
tools: Read, Grep, Glob, Bash
---

`.agents/AGENTS.md` is this repo's living spec for agents: directory inventories, link mappings, workflows, counts. It drifts — recent commits exist purely to catch it up (`docs(agents): refresh AGENTS.md …`). Your job: verify its claims against the working tree and propose a minimal patch. Do not rewrite prose or restructure the document.

## Procedure

1. Get the change set: `git status --short` and `git diff --name-only HEAD`; if the tree is clean, use the last commit (`git show --stat --format= HEAD`).
2. For each touched area, find claims in `.agents/AGENTS.md` that are now false. Repeat offenders: per-directory file inventories and counts (`home/vim/lua/plugins/`, karabiner `rules/`), `Brewfile` counts (taps / formulae / casks / mas), documented commands (`npm run …`, `./install …`), link-target lists and `if:` guards, the "Notable config files" list.
3. Prove each new value with a command — `ls home/vim/lua/plugins | wc -l`, `grep -c '^brew ' Brewfile`, `git ls-files home/karabiner`, etc. Never "fix" a claim without evidence.
4. Output a unified diff (or exact before/after lines), one per contradicted claim, each with the proving command. If nothing drifted, say so.

## Recently resolved (don't re-flag)

- 2026-09-29 — Karabiner: dangling imports dropped (`rules/onepassword.ts` + its rule gone, `hyper.ts` recreated, `resolve-mac.ts` inlined), AGENTS.md karabiner section aligned to the tree (`bun index.ts` instead of npm scripts). `package.json`/`tsconfig.json` remain absent by choice — recoverable from dangling commit `d54e444` / `stash@{0}`.
- 2026-09-29 — `.claude/CLAUDE.md` pointer fixed to `../.agents/AGENTS.md`.
