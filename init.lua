vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config.options")
require("config.keymaps")
require("config.filetypes")
require("config.autocmds")
require("plugins")

local lsp_activate = require("config.lsp.activate")
local workflows = require("config.workflows")

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

-- Workflows decide when each LSP is relevant for the current project or buffer.
workflows.each(function(workflow, name)
	workflow.register_lsps(lsp_activate, function(context)
		return workflows.is_active(name, context)
	end)
end)
