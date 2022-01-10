local status_ok, signature = pcall(require, "lsp_signature")
if not status_ok then
  return
end

local cfg = {
	bind = true,
	doc_lines = 0,
	floating_window = true,
	fix_pos = true,
	hint_enable = true,
	hint_prefix = " ",
	hint_scheme = "String",
	hi_parameter = "Search",
	max_height = 22,
	max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
	handler_opts = {
		border = "single", -- double, single, shadow, none
	},
	zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
	padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
}

-- recommanded:
signature.setup(cfg) -- no need to specify bufnr if you don't use toggle_key

-- You can also do this inside lsp on_attach
-- note: on_attach deprecated
-- require("lsp_signature").on_attach(cfg, bufnr) -- no need to specify bufnr if you don't use toggle_key
signature.on_attach(cfg) -- no need to specify bufnr if you don't use toggle_key
