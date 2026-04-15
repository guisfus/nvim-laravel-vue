local filetypes = {}

local function merge_map(target, source)
	for key, value in pairs(source or {}) do
		target[key] = value
	end
end

require("config.workflows").each(function(workflow)
	local config = workflow.filetypes and workflow.filetypes() or {}

	filetypes.extension = filetypes.extension or {}
	filetypes.pattern = filetypes.pattern or {}

	merge_map(filetypes.extension, config.extension)
	merge_map(filetypes.pattern, config.pattern)
end)

vim.filetype.add(filetypes)
