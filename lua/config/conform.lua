local M = {}

local function resolve_php_formatters(bufnr, workflows)
	for _, workflow in ipairs(workflows) do
		local config = workflow.conform and workflow.conform() or nil
		local php_formatter = config and config.php_formatter or nil
		if php_formatter then
			local formatters = php_formatter(bufnr)
			if formatters and not vim.tbl_isempty(formatters) then
				return formatters
			end
		end
	end

	return {}
end

function M.setup()
	local workflow_modules = {}
	local formatters = {}
	local formatters_by_ft = {}

	-- Workflows contribute formatter definitions and filetype mappings.
	require("config.workflows").each(function(workflow)
		workflow_modules[#workflow_modules + 1] = workflow

		local config = workflow.conform and workflow.conform() or nil
		if not config then
			return
		end

		for name, formatter in pairs(config.formatters or {}) do
			formatters[name] = formatter
		end

		for filetype, formatter_list in pairs(config.formatters_by_ft or {}) do
			formatters_by_ft[filetype] = formatter_list
		end
	end)

	formatters_by_ft.php = function(bufnr)
		-- PHP is selected dynamically so branch-specific Laravel rules stay isolated.
		return resolve_php_formatters(bufnr, workflow_modules)
	end

	require("conform").setup({
		formatters = formatters,
		formatters_by_ft = formatters_by_ft,

		default_format_opts = {
			lsp_format = "fallback",
		},

		format_on_save = {
			timeout_ms = 1000,
		},
	})
end

return M
