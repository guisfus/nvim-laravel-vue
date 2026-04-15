local M = {}

function M.find_upward(path, markers)
	return vim.fs.find(markers, {
		upward = true,
		path = path,
	})[1]
end

function M.resolve_local_or_global(ctx, local_binary, global_binary)
	local local_path = vim.fs.find(local_binary, {
		upward = true,
		path = ctx.dirname,
	})[1]

	if local_path then
		return local_path
	end

	return global_binary
end

function M.context_path(context)
	context = context or {}

	if context.path and context.path ~= "" then
		return context.path
	end

	if context.bufnr then
		local filename = vim.api.nvim_buf_get_name(context.bufnr)
		if filename ~= "" then
			return filename
		end
	end

	return vim.uv.cwd()
end

function M.context_dir(context)
	local path = M.context_path(context)
	if not path or path == "" then
		return nil
	end

	local stat = vim.uv.fs_stat(path)
	if stat and stat.type == "directory" then
		return path
	end

	return vim.fs.dirname(path)
end

function M.context_filetype(context)
	context = context or {}

	if context.filetype and context.filetype ~= "" then
		return context.filetype
	end

	if context.bufnr then
		return vim.bo[context.bufnr].filetype
	end

	return ""
end

function M.has_marker(context, markers)
	local dir = M.context_dir(context)
	if not dir then
		return false
	end

	return M.find_upward(dir, markers) ~= nil
end

return M
