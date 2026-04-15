local M = {}

local helpers = require("config.workflows.helpers")

function M.is_active(context)
	local filetype = helpers.context_filetype(context)
	if filetype == "blade" then
		return true
	end

	return helpers.has_marker(context, { "artisan" })
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
		formatters = {
			pint = {
				command = function(ctx)
					return helpers.resolve_local_or_global(ctx, "vendor/bin/pint", "pint")
				end,
				args = { "$FILENAME" },
				stdin = false,
			},
		},
		php_formatter = function(bufnr)
			local filename = vim.api.nvim_buf_get_name(bufnr)
			local dirname = vim.fs.dirname(filename)
			local conform = require("conform")

			if dirname and helpers.find_upward(dirname, { "artisan" }) then
				return { "pint" }
			end

			if conform.get_formatter_info("pint", bufnr).available then
				return { "pint" }
			end
		end,
	}
end

function M.register_lsps(_) end

return M
