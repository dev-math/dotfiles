local ok, notify = pcall(require, "notify")
if not ok then
	return
end

local config = {
	background_colour = "#000000",
	stages = "fade",
	timeout = 5000,
}

notify.setup(config)
vim.notify = notify
vim.keymap.set("", "<Esc>", "<ESC>:noh<CR>:lua require('notify').dismiss()<CR>", { silent = true })
