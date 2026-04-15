local M = {}

local loaded = {}

M.names = { "core", "frontend", "laravel" }

local function get_workflow(name)
	if not loaded[name] then
		loaded[name] = require("config.workflows." .. name)
	end

	return loaded[name]
end

function M.each(callback)
	for _, name in ipairs(M.names) do
		callback(get_workflow(name), name)
	end
end

function M.is_active(name, context)
	local workflow = get_workflow(name)
	if not workflow.is_active then
		return true
	end

	return workflow.is_active(context or {})
end

function M.each_active(context, callback)
	-- Use context-aware activation so this branch stays lean in non-Laravel buffers.
	M.each(function(workflow, name)
		if M.is_active(name, context) then
			callback(workflow, name)
		end
	end)
end

return M
