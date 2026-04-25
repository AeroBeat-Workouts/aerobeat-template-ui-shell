# AeroBeat UI Shell Template

This is the official template for creating a **UI Shell** repository within the AeroBeat ecosystem.

## 📋 Repository Details

*   **Type:** UI Shell
*   **License:** **GNU GPLv3** (Strict Copyleft)
*   **Dependencies:**
    *   `aerobeat-ui-core` (Required UI logic contract)
    *   `aerobeat-ui-kit-community` (Pinned visual layer)
    *   Additional lane/core repos only when the shell actually consumes them

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

That restores this repo's current dev/test manifest into `.testbed/addons/`. Canonically, UI shell repos should describe themselves around `aerobeat-ui-core` plus the concrete UI kit and any other lane repos the shell actually consumes.

### Open the workbench

From the repo root:

```bash
godot --editor --path .testbed
```

Use this `.testbed/` project as the canonical direct-development and bugfinding surface for UI-shell work.

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
- The current manifest still pins the transition-era `aerobeat-core` package key alongside `aerobeat-ui-core` and `aerobeat-ui-kit-community`. Treat that old core pin as bootstrap-state drift rather than the canonical lane model.
- Canonical shared dependency language for UI shell repos is `aerobeat-ui-core` plus the concrete UI kit and any additional lane repos the shell actually consumes.
- Repo-local unit tests live under `.testbed/tests/`; this repo's current package payload is rooted at `/`, so the workbench does not ship a `.testbed/src` bridge for this subset.
- The current package shape is consumed from the repo root (`subfolder: "/"`) for downstream installs.
