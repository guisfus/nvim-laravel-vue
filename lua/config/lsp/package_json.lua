local M = {}

local function read_file(path)
	local lines = vim.fn.readfile(path)
	if vim.tbl_isempty(lines) then
		return ""
	end

	return table.concat(lines, "\n")
end

function M.find_root(bufnr, matches)
	local filename = vim.api.nvim_buf_get_name(bufnr)
	if filename == "" then
		return nil
	end

	local package_json = vim.fs.find("package.json", {
		path = vim.fs.dirname(filename),
		upward = true,
		type = "file",
	})[1]

	if not package_json then
		return nil
	end

	local content = read_file(package_json)
	if content == "" or not matches(content) then
		return nil
	end

	return vim.fs.dirname(package_json)
end

return M
