local ok, nvimtree = pcall(require, "nvim-tree")
if not ok then
  return
end

nvimtree.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  open_on_setup_file = false,
  ignore_buffer_on_setup = false,
  auto_reload_on_write = true,
  hijack_unnamed_buffer_when_opening = false,
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  open_on_tab = false,
  hijack_cursor = false,
  update_cwd = false,
  sort_by = "name",
  ignore_ft_on_setup = {
    "startify",
    "dashboard",
    "alpha",
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
    },
  },
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  git = {
    ignore = false,
    timeout = 200,
  },
  view = {
    number = true,
    relativenumber = true,
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
        { key = "h", action = "close_node" },
        { key = "s", action = "split" },
        { key = "v", action = "vsplit" },
        { key = "C", action = "cd" },
        { key = "<S-o>", action = "system_open" },
      }
    }
  },
  renderer = {
    icons = {
      glyphs = {
        default = "",
        symlink = "",
        git = {
          unstaged = "",
          untracked = "U",
        },
      },
    },
    highlight_git = true,
    root_folder_modifier = ":t",
  },
  trash = {
    cmd = "trash",
  },
})


local keymap = vim.keymap.set -- Shorten function name
local opts = { noremap = true, silent = true }

-- Toggle file explorer --
keymap('n', '<C-b>', ':NvimTreeToggle<CR>', opts)
keymap('i', '<C-b>', '<Esc>:NvimTreeToggle<CR>', opts)
keymap('v', '<C-b>', '<Esc>:NvimTreeToggle<CR>', opts)

-- -- Autoclose nvim is nvim-tree is only buffer open
-- vim.api.nvim_create_autocmd('BufEnter', {
--   command = [[if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif]],
--   group = vim.api.nvim_create_augroup('NvimNvimTree', { clear = true }),
--   nested = true,
-- })
