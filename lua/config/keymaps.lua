local map = vim.keymap.set

-- Windows
map("n", "<C-h>", "<C-w>h", { desc = "Left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Down window" })
map("n", "<C-k>", "<C-w>k", { desc = "Up window" })
map("n", "<C-l>", "<C-w>l", { desc = "Right window" })

-- Buffers
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Previus buffer" })
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
map("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Cerrar buffer" })

-- Explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Explorer toggle" })
map("n", "<leader>o", "<cmd>NvimTreeFocus<cr>", { desc = "Explorer focus" })
map("n", "<leader>fe", "<cmd>NvimTreeFindFile<cr>", { desc = "Actual file explorer" })

-- Search
map("n", "<leader>ff", function()
	require("fzf-lua").files()
end, { desc = "Find files" })

map("n", "<leader>fg", function()
	require("fzf-lua").live_grep()
end, { desc = "Find text" })

map("n", "<leader>fb", function()
	require("fzf-lua").buffers()
end, { desc = "Buffers" })

map("n", "<leader>fh", function()
	require("fzf-lua").help_tags()
end, { desc = "Help tags" })

map("n", "<leader>fr", function()
	require("fzf-lua").oldfiles()
end, { desc = "Recent files" })

-- Diagnostics
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Diagnostics by line" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previus diagnostic" })

-- Trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics" })
map("n", "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer diagnostics" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP list" })
map("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location list" })
map("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix list" })

-- Utilities
map("n", "<leader>fc", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format" })
