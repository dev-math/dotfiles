local M = {}

function M.merge(...)
	return vim.tbl_deep_extend("force", ...)
end

function M.contains(tbl, x)
	local found = false
	for _, v in pairs(tbl) do
		if v == x then
			found = true
		end
	end
	return found
end

return M
