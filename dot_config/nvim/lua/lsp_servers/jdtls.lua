local ok, java = pcall(require, "java")
if not ok then
	vim.notify("Unable to load java config")
	return {}
end

java.setup()

return {}
