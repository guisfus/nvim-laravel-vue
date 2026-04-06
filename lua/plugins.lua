local gh = function(repo)
	return "https://github.com/" .. repo
end

vim.pack.add({
	-- Treesitter
	{ src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },

	-- Dependencies / base utilities
	gh("nvim-lua/plenary.nvim"),
	gh("nvim-tree/nvim-web-devicons"),
	gh("nvim-mini/mini.icons"),

	-- LSP / formatting / lint
	gh("neovim/nvim-lspconfig"),
	gh("stevearc/conform.nvim"),

	-- Completion / snippets
	gh("hrsh7th/nvim-cmp"),
	gh("hrsh7th/cmp-nvim-lsp"),
	gh("hrsh7th/cmp-buffer"),
	gh("hrsh7th/cmp-path"),
	gh("L3MON4D3/LuaSnip"),
	gh("saadparwaiz1/cmp_luasnip"),
	gh("rafamadriz/friendly-snippets"),

	-- Navigation / search
	gh("ibhagwan/fzf-lua"),
	gh("nvim-tree/nvim-tree.lua"),

	-- Git / diagnostics
	gh("lewis6991/gitsigns.nvim"),
	gh("folke/trouble.nvim"),

	-- Editing
	gh("folke/which-key.nvim"),
	gh("numToStr/Comment.nvim"),
	gh("windwp/nvim-autopairs"),
	gh("RRethy/vim-illuminate"),

	-- UI
	gh("nvim-lualine/lualine.nvim"),
	gh("akinsho/bufferline.nvim"),
	gh("lukas-reineke/indent-blankline.nvim"),
	gh("ellisonleao/gruvbox.nvim"),

	-- Laravel
	gh("MunifTanjim/nui.nvim"),
	gh("nvim-lua/plenary.nvim"),
	gh("adibhanna/laravel.nvim"),
})

vim.cmd.colorscheme("gruvbox")
