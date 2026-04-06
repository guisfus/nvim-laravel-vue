local M = {}

function M.setup()
	local ok, laravel = pcall(require, "laravel")
	if not ok then
		vim.schedule(function()
			vim.notify("Could not load: laravel", vim.log.levels.WARN)
		end)
		return
	end

	laravel.setup({
		notifications = true,
		debug = false,
		keymaps = false,
		sail = {
			enabled = true,
			auto_detect = true,
		},
	})

	vim.keymap.set("n", "<leader>la", "<cmd>Artisan<CR>", { desc = "Laravel Artisan" })
	vim.keymap.set("n", "<leader>lc", "<cmd>Composer<CR>", { desc = "Laravel Composer" })
	vim.keymap.set("n", "<leader>lr", "<cmd>LaravelRoute<CR>", { desc = "Laravel Routes" })
	vim.keymap.set("n", "<leader>lm", "<cmd>LaravelMake<CR>", { desc = "Laravel Make" })
	vim.keymap.set("n", "<leader>ls", "<cmd>LaravelStatus<CR>", { desc = "Laravel Status" })
end

return M
