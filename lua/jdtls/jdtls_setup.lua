local M = {}

function M.setup()
	local jdtls = require("jdtls")

	local sep = package.config:sub(1, 1)
	local home = vim.fn.stdpath("data")

	-- mason paths
	local jdtls_pkg = home .. sep .. "mason" .. sep .. "packages" .. sep .. "jdtls"
	local jdtls_share = home .. sep .. "mason" .. sep .. "share" .. sep .. "jdtls"

	-- workspace per project
	local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
	local workspace_dir = home .. sep .. "jdtls-workspace" .. sep .. project_name

	local os_name = vim.loop.os_uname().sysname
	local config_dir = jdtls_pkg
		.. sep
		.. "config_"
		.. (os_name == "Windows_NT" and "win" or os_name == "Linux" and "linux" or "mac")

	local launcher = vim.fn.glob(jdtls_pkg .. sep .. "plugins" .. sep .. "org.eclipse.equinox.launcher_*.jar")

	local lombok = jdtls_share .. sep .. "lombok.jar"

	local root_dir = require("jdtls.setup").find_root({
		"gradlew",
		"mvnw",
		"build.gradle",
		"build.gradle.kts",
		"settings.gradle",
		"settings.gradle.kts",
		".git",
	})

	local config = {
		cmd = {
			"/Users/kberdyshev/.sdkman/candidates/java/current/bin/java",
			"-Declipse.application=org.eclipse.jdt.ls.core.id1",
			"-Dosgi.bundles.defaultStartLevel=4",
			"-Declipse.product=org.eclipse.jdt.ls.core.product",
			"-Dlog.protocol=true",
			"-Dlog.level=ALL",
			"-Xmx1g",
			"--add-modules=ALL-SYSTEM",
			"--add-opens",
			"java.base/java.util=ALL-UNNAMED",
			"--add-opens",
			"java.base/java.lang=ALL-UNNAMED",

			"-javaagent:" .. lombok,

			"-jar",
			launcher,
			"-configuration",
			config_dir,
			"-data",
			workspace_dir,
		},

		root_dir = root_dir,

		settings = {
			java = {
				configuration = {
					updateBuildConfiguration = "automatic",
				},
				import = {
					gradle = {
						enabled = true,
						wrapper = {
							enabled = true, -- чтобы он юзал ./gradlew, если есть
						},
					},
					maven = {
						enabled = true,
					},
				},
			},
		},

		init_options = {
			bundles = {},
		},
	}

	jdtls.start_or_attach(config)
end

return M
