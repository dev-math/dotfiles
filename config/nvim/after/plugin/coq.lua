local coq_settings = {
	clients = {
		lsp = {
			resolve_timeout = 1,
			always_on_top = {},
			short_name = "[LSP]",
			enabled = true,
			weight_adjust = 1.5,
		},
		buffers = {
			short_name = "[Buffer]",
			weight_adjust = 1.1,
		},
		snippets = {
			short_name = "[Snippet]",
			weight_adjust = 1.4,
		},
		paths = {
			short_name = "[Path]",
			weight_adjust = 1.3,
		},
		tree_sitter = {
			enabled = true,
		},
		tmux = {
			enabled = true,
		},
	},
	keymap = {
		recommended = false,
		bigger_preview = "null",
		jump_to_mark = "null",
	},
	limits = {
		completion_auto_timeout = 0.77,
		completion_manual_timeout = 077,
	},
	display = {
		["icons.mode"] = "none",
		ghost_text = {
			context = { "", "" },
		},
		pum = {
			fast_close = false,
			source_context = { "", "" },
		},
	},
}

vim.api.nvim_set_var("coq_settings", coq_settings)

local ok, coq_3p = pcall(require, "coq_3p")
if not ok then
	return
end

vim.cmd([[
ino <silent><expr> <Esc>   pumvisible() ? "\<C-e><Esc>" : "\<Esc>"
ino <silent><expr> <C-c>   pumvisible() ? "\<C-e><C-c>" : "\<C-c>"
ino <silent><expr> <BS>    pumvisible() ? "\<C-e><BS>"  : "\<BS>"
ino <silent><expr> <CR>    pumvisible() ? (complete_info().selected == -1 ? "\<C-e>" : "\<C-y>") : "\<CR>"
ino <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
ino <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<BS>"
ino <silent><expr> <C-j>   pumvisible() ? "\<C-n>" : "\<Tab>"
ino <silent><expr> <C-k>   pumvisible() ? "\<C-p>" : "\<BS>"
]])

coq_3p({
	{ src = "nvimlua", short_name = "[Lua]", weight_adjust = 1.2 },
	{ src = "vimtex", short_name = "[TEX]" },
	-- { src = "bc", short_name = "MATH", precision = 6 },
})

require("coq")
vim.cmd("COQnow --shut-up")
