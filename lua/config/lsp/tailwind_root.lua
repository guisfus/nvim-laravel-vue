local package_json = require("config.lsp.package_json")

local config_markers = {
	"tailwind.config.js",
	"tailwind.config.cjs",
	"tailwind.config.mjs",
	"tailwind.config.ts",
	"postcss.config.js",
	"postcss.config.cjs",
	"postcss.config.mjs",
	"postcss.config.ts",
}

return function(bufnr, on_dir)
	local root = vim.fs.root(bufnr, config_markers)
	if root then
		on_dir(root)
		return
	end

	root = package_json.find_root(bufnr, function(content)
		return content:match('"tailwindcss"') ~= nil
	end)

	if root then
		on_dir(root)
	end
end
