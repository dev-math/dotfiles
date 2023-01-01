local M = {}

-- Mappings.
function M.init(_, bufnr)
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("v", "<leader>ca", vim.lsp.buf.range_code_action, bufopts)

	vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, bufopts)
	vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, bufopts)
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, bufopts)
	vim.keymap.set("n", "<leader>ds", require("telescope.builtin").lsp_document_symbols, bufopts)
	vim.keymap.set("n", "<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, bufopts)

	vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gt", require("telescope.builtin").lsp_type_definitions, bufopts)
	vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
	vim.keymap.set("n", "<leader>wl", function()
		print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	end, bufopts)
	vim.keymap.set("n", "<leader>i", vim.lsp.buf.format, bufopts)
	vim.keymap.set("v", "<leader>i", vim.lsp.buf.range_formatting, bufopts)

	-- -- Create a command `:Format` local to the LSP buffer
	-- vim.api.nvim_buf_create_user_command(
	-- 	bufnr,
	-- 	"Format",
	-- 	vim.lsp.buf.format,
	-- 	{ desc = "Format current buffer with LSP" }
	-- )
end

return M
