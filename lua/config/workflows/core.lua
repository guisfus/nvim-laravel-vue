local M = {}

function M.is_active(_)
	return true
end

function M.filetypes()
	return {
		pattern = {
			[".*%.blade%.php"] = "blade",
		},
	}
end

function M.plugins()
	return {
		{ repo = "nvim-treesitter/nvim-treesitter", version = "main" },
		{ repo = "nvim-lua/plenary.nvim" },
		{ repo = "nvim-tree/nvim-web-devicons" },
		{ repo = "nvim-mini/mini.icons" },
		{ repo = "neovim/nvim-lspconfig" },
		{ repo = "stevearc/conform.nvim" },
		{ repo = "hrsh7th/nvim-cmp" },
		{ repo = "hrsh7th/cmp-nvim-lsp" },
		{ repo = "hrsh7th/cmp-buffer" },
		{ repo = "hrsh7th/cmp-path" },
		{ repo = "L3MON4D3/LuaSnip" },
		{ repo = "saadparwaiz1/cmp_luasnip" },
		{ repo = "rafamadriz/friendly-snippets" },
		{ repo = "ibhagwan/fzf-lua" },
		{ repo = "nvim-tree/nvim-tree.lua" },
		{ repo = "lewis6991/gitsigns.nvim" },
		{ repo = "folke/trouble.nvim" },
		{ repo = "folke/which-key.nvim" },
		{ repo = "numToStr/Comment.nvim" },
		{ repo = "windwp/nvim-autopairs" },
		{ repo = "RRethy/vim-illuminate" },
		{ repo = "nvim-lualine/lualine.nvim" },
		{ repo = "akinsho/bufferline.nvim" },
		{ repo = "lukas-reineke/indent-blankline.nvim" },
		{ repo = "ellisonleao/gruvbox.nvim" },
	}
end

function M.plugin_configs()
	return {
		"config.conform",
		"config.treesitter",
		"config.cmp",
		"config.nvimtree",
		"config.bufferline",
		"config.trouble",
	}
end

function M.conform()
	return {
		formatters_by_ft = {
			lua = { "stylua" },
			html = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
		},
	}
end

function M.register_lsps(activate, is_active)
	activate.register("lua_ls", "lua-language-server", { "lua" }, { should_enable = is_active })
	activate.register("intelephense", "intelephense", { "php" }, { should_enable = is_active })
	activate.register("html", "vscode-html-language-server", { "html", "blade" }, { should_enable = is_active })
	activate.register("marksman", "marksman", { "markdown" }, { should_enable = is_active })
end

return M
