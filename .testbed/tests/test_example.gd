extends GutTest

const README_PATH := "../README.md"
const PLUGIN_CFG_PATH := "../plugin.cfg"
const ADDONS_MANIFEST_PATH := "addons.jsonc"
const EXPECTED_PLUGIN_DESCRIPTION := "Template for AeroBeat UI shell repos. Baseline shared UI logic plus community UI kit bootstrap for current v1 shell work."

func _read_repo_file(relative_path: String) -> String:
	var absolute_path := ProjectSettings.globalize_path("res://%s" % relative_path)
	assert_true(FileAccess.file_exists(absolute_path), "Expected repo file to exist: %s" % absolute_path)
	var file := FileAccess.open(absolute_path, FileAccess.READ)
	assert_true(file != null, "Expected repo file to open: %s" % absolute_path)
	return file.get_as_text()

func test_readme_keeps_v1_ui_shell_template_truth() -> void:
	var readme_text := _read_repo_file(README_PATH)
	assert_true(readme_text.contains("official template for creating **UI shell** repositories"), "README should state that this repo is a UI shell template")
	assert_true(readme_text.contains("PC community first"), "README should preserve PC-first release wording")
	assert_true(readme_text.contains("Boxing and Flow"), "README should preserve the locked v1 feature slice")
	assert_true(readme_text.contains("camera only"), "README should preserve camera-only official gameplay input wording")
	assert_true(readme_text.contains("mouse and touch remain valid for UI navigation"), "README should keep UI-only mouse/touch wording")

func test_plugin_cfg_description_stays_template_specific() -> void:
	var config := ConfigFile.new()
	var error := config.load(ProjectSettings.globalize_path("res://%s" % PLUGIN_CFG_PATH))
	assert_eq(error, OK, "plugin.cfg should parse cleanly")
	assert_eq(config.get_value("plugin", "name", ""), "AeroBeat UI Shell Template", "plugin.cfg name should stay stable")
	assert_eq(
		config.get_value("plugin", "description", ""),
		EXPECTED_PLUGIN_DESCRIPTION,
		"plugin.cfg description should remain aligned with the template's narrow v1 UI-shell contract"
	)

func test_addons_manifest_keeps_expected_dependencies_only() -> void:
	var manifest_text := _read_repo_file(ADDONS_MANIFEST_PATH)
	assert_true(manifest_text.contains('"aerobeat-ui-core"'), "addons manifest should pin aerobeat-ui-core")
	assert_true(manifest_text.contains('"aerobeat-ui-kit-community"'), "addons manifest should pin aerobeat-ui-kit-community")
	assert_true(manifest_text.contains('"gut"'), "addons manifest should pin gut for repo-local tests")
	assert_false(manifest_text.contains('"aerobeat-core"'), "addons manifest should not reintroduce stale aerobeat-core drift")
