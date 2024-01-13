require("NeoSolarized").setup({
	enable_italics = false,
	transparent = true,
	-- style = "light",
})

vim.cmd.colorscheme("NeoSolarized")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
