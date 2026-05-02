# AeroBeat UI Shell Template

This is the official template for creating **UI shell** repositories within the current AeroBeat v1 architecture.

It should be read against the locked product direction from `aerobeat-docs`:

- **Primary release target:** PC community first
- **Official v1 gameplay features:** Boxing and Flow
- **Official v1 gameplay input:** camera only
- **UI input stance:** mouse and touch remain valid for UI navigation, without implying equal-status gameplay input support
- **Future shell work:** mobile, web, and XR can remain future-facing shell variants when they are labeled honestly

## 📋 Repository Details

- **Type:** UI Shell template
- **License:** **GNU GPLv3** (Strict Copyleft)
- **Dependency contract:**
  - `aerobeat-ui-core` — required shared UI logic contract
  - `aerobeat-ui-kit-community` — baseline community visual layer for template bootstrap
  - additional lane/core repos only when the shell actually consumes them

## GodotEnv development flow

This repo uses the AeroBeat GodotEnv UI shell convention.

- Canonical dev/test manifest: `.testbed/addons.jsonc`
- Installed dev/test addons: `.testbed/addons/`
- GodotEnv cache: `.testbed/.addons/`
- Hidden workbench project: `.testbed/project.godot`
- Repo-local unit tests: `.testbed/tests/`

The repo root remains the package/published boundary for downstream consumers. Day-to-day development, debugging, and validation happen from the hidden `.testbed/` workbench using the pinned OpenClaw toolchain: Godot `4.6.2 stable standard`.

### Restore dev/test dependencies

From the repo root:

```bash
cd .testbed
godotenv addons install
```

That restores this repo's current dev/test manifest into `.testbed/addons/`. Canonically, UI shell templates should keep the baseline manifest narrow: shared UI logic, the community UI kit, and test-only tooling.

### Open the workbench

From the repo root:

```bash
godot --editor --path .testbed
```

Use this `.testbed/` project as the canonical direct-development and bugfinding surface for UI-shell template work.

### Import smoke check

From the repo root:

```bash
godot --headless --path .testbed --import
```

### Run unit tests

From the repo root:

```bash
godot --headless --path .testbed --script addons/gut/gut_cmdln.gd \
  -gdir=res://tests \
  -ginclude_subdirs \
  -gexit
```

### Validation notes

- `.testbed/addons.jsonc` is the committed dev/test dependency contract.
- The canonical template manifest for this repo is `aerobeat-ui-core` + `aerobeat-ui-kit-community` + `gut`.
- If a concrete shell needs additional lane repos, add them intentionally rather than restoring a universal `aerobeat-core` baseline.
- Repo-local unit tests live under `.testbed/tests/` and currently validate repo metadata plus the manifest contract.
- The current package shape is consumed from the repo root (`subfolder: "/"`) for downstream installs.
