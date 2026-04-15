local function safe_setup(module, callback)
	local ok, loaded = pcall(require, module)
	if not ok then
		vim.schedule(function()
			vim.notify(string.format("Could not be loaded: '%s'", module), vim.log.levels.WARN)
		end)
		return
	end

	callback(loaded)
end

local function safe_run_config(module)
	safe_setup(module, function(config)
		config.setup()
	end)
end

-- Editing / UX
safe_setup("which-key", function(which_key)
	which_key.setup()
end)

safe_setup("Comment", function(comment)
	comment.setup()
end)

safe_setup("nvim-autopairs", function(autopairs)
	autopairs.setup()
end)

-- Git / UI base / search
safe_setup("gitsigns", function(gitsigns)
	gitsigns.setup()
end)

safe_setup("ibl", function(indent_blankline)
	indent_blankline.setup()
end)

safe_setup("lualine", function(lualine)
	lualine.setup({
		options = { theme = "auto", globalstatus = true },
	})
end)

safe_setup("fzf-lua", function(fzf)
	fzf.setup({})
end)

-- Modular configurations
require("config.workflows").each_active({ path = vim.uv.cwd() }, function(workflow)
	for _, module in ipairs(workflow.plugin_configs()) do
		safe_run_config(module)
	end
end)
