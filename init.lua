vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.filetypes")
require("config.autocmds")
require("plugins")

local function enable_lsp_if_executable(name, cmd)
	if vim.fn.executable(cmd) == 1 then
		vim.lsp.enable(name)
		return
	end

	vim.schedule(function()
		vim.notify(string.format("LSP '%s' not enabled: requires the binary -> '%s'", name, cmd), vim.log.levels.WARN)
	end)
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = desc })
		end

		map("n", "K", vim.lsp.buf.hover, "Hover")
		map("n", "gd", vim.lsp.buf.definition, "Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Implementation")
		map("n", "go", vim.lsp.buf.type_definition, "Type definition")
		map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
		map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
	end,
})

local cmp_capabilities = require("cmp_nvim_lsp").default_capabilities()
vim.lsp.config("*", {
	capabilities = cmp_capabilities,
})

enable_lsp_if_executable("lua_ls", "lua-language-server")
enable_lsp_if_executable("intelephense", "intelephense")
enable_lsp_if_executable("html", "vscode-html-language-server")
enable_lsp_if_executable("tailwindcss", "tailwindcss-language-server")
enable_lsp_if_executable("ts_ls", "typescript-language-server")
enable_lsp_if_executable("vue_ls", "vue-language-server")
enable_lsp_if_executable("eslint", "vscode-eslint-language-server")
enable_lsp_if_executable("marksman", "marksman")
