import { $ } from "bun";

import { apps } from "../apps.ts";

// Cross-checks apps.ts's hardcoded bundle-id regexes against what's actually
// installed right now, via `mdfind`/`mdls`. Only checks
// single-app entries where the macOS display name is known — group
// entries (terminals, escapeApps, firefoxes) aren't checked.
//
// Run with: bun run scripts/verify-ids.ts

// Inlined from the retired resolve-mac.ts (the file is not in the tree).
async function extractIdentifier(appName: string): Promise<string> {
  const paths =
    await $`mdfind "kMDItemKind == 'Application' && kMDItemFSName == '${appName}.app'"`.text();
  const appPath = paths.trim().split("\n")[0];
  if (!appPath) {
    throw new Error(`Application ${appName} not found`);
  }

  const output = await $`mdls -name kMDItemCFBundleIdentifier ${appPath}`.text();
  const identifier = output.match(/"(.*)"/)?.[1]?.trim();
  if (!identifier) {
    throw new Error(`Failed to extract bundle identifier for ${appName}`);
  }

  return identifier;
}

const appNameByKey: Partial<Record<keyof typeof apps, string>> = {
  calendar: "Calendar",
  mail: "Mail",
  omnifocus4: "OmniFocus",
  finder: "Finder",
  reeder: "Reeder",
  discord: "Discord",
  safari: "Safari",
  onep: "1Password",
  firefox: "Firefox",
  firefoxdev: "Firefox Developer Edition",
  wezterm: "WezTerm",
  ghostty: "Ghostty",
  neovide: "Neovide",
  silicio: "Silicio",
  terminal: "Terminal",
};

let mismatches = 0;

for (const [key, appName] of Object.entries(appNameByKey)) {
  const expected = apps[key as keyof typeof apps];

  try {
    const actual = await extractIdentifier(appName);
    const matches = expected.some((pattern) =>
      new RegExp(pattern).test(actual)
    );

    if (matches) {
      console.log(`ok       ${key.padEnd(12)} ${appName} -> ${actual}`);
    } else {
      mismatches++;
      console.log(
        `MISMATCH ${key.padEnd(12)} ${appName} -> ${actual}  (apps.ts has: ${
          expected.join(", ")
        })`,
      );
    }
  } catch (e) {
    mismatches++;
    console.log(
      `ERROR    ${key.padEnd(12)} ${appName}: ${(e as Error).message}`,
    );
  }
}

if (mismatches > 0) {
  console.log(`\n${mismatches} mismatch(es)/error(s) — update apps.ts.`);
  process.exit(1);
}
console.log("\nAll checked bundle ids match.");
