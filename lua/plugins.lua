local gh = function(repo)
	return "https://github.com/" .. repo
end

local plugins = {}
local seen = {}

-- Each workflow contributes plugin specs; this file only merges them.
require("config.workflows").each(function(workflow)
	for _, spec in ipairs(workflow.plugins()) do
		local key = spec.repo or spec.src
		if not seen[key] then
			seen[key] = true

			if spec.repo then
				plugins[#plugins + 1] = spec.version and { src = gh(spec.repo), version = spec.version }
					or gh(spec.repo)
			else
				plugins[#plugins + 1] = spec
			end
		end
	end
end)

vim.pack.add(plugins)

vim.cmd.colorscheme("gruvbox")
