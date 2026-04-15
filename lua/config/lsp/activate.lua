local M = {}

local enabled = {}
local warned = {}
local group = vim.api.nvim_create_augroup("deferred-lsp-enable", { clear = true })

function M.register(name, cmd, filetypes, opts)
	opts = opts or {}

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = filetypes,
		callback = function(args)
			if
				opts.should_enable
				and not opts.should_enable({ bufnr = args.buf, filetype = vim.bo[args.buf].filetype })
			then
				return
			end

			if enabled[name] then
				return
			end

			if vim.fn.executable(cmd) == 1 then
				enabled[name] = true
				vim.lsp.enable(name)
				return
			end

			if opts.notify_missing == false or warned[name] then
				return
			end

			warned[name] = true
			vim.schedule(function()
				vim.notify(
					string.format("LSP '%s' not enabled: requires the binary -> '%s'", name, cmd),
					vim.log.levels.WARN
				)
			end)
		end,
	})
end

return M
