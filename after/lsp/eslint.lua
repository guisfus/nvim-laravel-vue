return {
	cmd = { "vscode-eslint-language-server", "--stdio" },
	filetypes = {
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"vue",
	},
	root_dir = require("config.lsp.eslint_root"),
	settings = {
		validate = "on",
		workingDirectory = { mode = "auto" },
		format = false,
	},
}
