local M = {}

local helpers = require("config.workflows.helpers")

function M.is_active(context)
	local filetype = helpers.context_filetype(context)
	if
		vim.tbl_contains(
			{ "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "css", "scss" },
			filetype
		)
	then
		return true
	end

	return helpers.has_marker(context, {
		"package.json",
		"tsconfig.json",
		"jsconfig.json",
		"vite.config.js",
		"vite.config.ts",
		"vite.config.mjs",
		"vite.config.cjs",
		"vue.config.js",
	})
end

function M.filetypes()
	return {}
end

function M.plugins()
	return {}
end

function M.plugin_configs()
	return {}
end

function M.conform()
	return {
		formatters_by_ft = {
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			vue = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
		},
	}
end

function M.register_lsps(activate, is_active)
	activate.register(
		"tailwindcss",
		"tailwindcss-language-server",
		{ "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "blade" },
		{ should_enable = is_active }
	)
	activate.register(
		"ts_ls",
		"typescript-language-server",
		{ "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		{ should_enable = is_active }
	)
	activate.register("vue_ls", "vue-language-server", { "vue" }, { should_enable = is_active })
	activate.register(
		"eslint",
		"vscode-eslint-language-server",
		{ "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
		{ should_enable = is_active }
	)
end

return M
