local package_json = require("config.lsp.package_json")

local config_markers = {
	"eslint.config.js",
	"eslint.config.mjs",
	"eslint.config.cjs",
	"eslint.config.ts",
	".eslintrc",
	".eslintrc.js",
	".eslintrc.cjs",
	".eslintrc.json",
	".eslintrc.yaml",
	".eslintrc.yml",
}

return function(bufnr, on_dir)
	local root = vim.fs.root(bufnr, config_markers)
	if root then
		on_dir(root)
		return
	end

	root = package_json.find_root(bufnr, function(content)
		return content:match('"eslintConfig"%s*:')
			or content:match('"eslint"%s*:')
			or content:match('"eslint%-plugin')
			or content:match('"eslint%-config')
			or content:match('"@eslint/')
	end)

	if root then
		on_dir(root)
	end
end
