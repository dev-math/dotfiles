local ok, bufferline = pcall(require, "bufferline")
if not ok then
  return
end

local function is_ft(b, ft)
  return vim.bo[b].filetype == ft
end

local function diagnostics_indicator(num, _, diagnostics, _)
  local result = {}
  local symbols = { error = "", warning = "", info = "" }
  for name, count in pairs(diagnostics) do
    if symbols[name] and count > 0 then
      table.insert(result, symbols[name] .. " " .. count)
    end
  end
  result = table.concat(result, " ")
  return #result > 0 and result or ""
end

local function custom_filter(buf, buf_nums)
  local logs = vim.tbl_filter(function(b)
    return is_ft(b, "log")
  end, buf_nums)
  if vim.tbl_isempty(logs) then
    return true
  end
  local tab_num = vim.fn.tabpagenr()
  local last_tab = vim.fn.tabpagenr "$"
  local is_log = is_ft(buf, "log")
  if last_tab == 1 then
    return true
  end
  -- only show log buffers in secondary tabs
  return (tab_num == last_tab and is_log) or (tab_num ~= last_tab and not is_log)
end

bufferline.setup {
  options = {
    tab_size = 20,
    right_mouse_command = "vert sbuffer %d", -- can be a string | function, see "Mouse actions"
    diagnostics = "nvim_lsp",
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    diagnostics_indicator = diagnostics_indicator,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = custom_filter,
    offsets = {
      {
        filetype = "undotree",
        text = "Undotree",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "NvimTree",
        text = "Explorer",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "DiffviewFiles",
        text = "Diff View",
        highlight = "PanelHeading",
        padding = 1,
      },
      {
        filetype = "flutterToolsOutline",
        text = "Flutter Outline",
        highlight = "PanelHeading",
      },
      {
        filetype = "packer",
        text = "Packer",
        highlight = "PanelHeading",
        padding = 1,
      },
    },
    show_close_icon = true,
    separator_style = "thin",
    always_show_bufferline = false,
    sort_by = "id",
  },
}

local keymap = vim.keymap.set -- Shorten function name
local opts = { noremap = true, silent = true }
keymap('n', '<Tab>', ':BufferLineCycleNext<cr>', opts)
keymap('n', '<S-Tab>', ':BufferLineCyclePrev<cr>', opts)
keymap('n', '<C-PageUp>', ':BufferLineCycleNext<cr>', opts)
keymap('n', '<C-PageDown>', ':BufferLineCyclePrev<cr>', opts)
keymap('n', '<S-PageUp>', ':BufferLineMovePrev<cr>', opts)
keymap('n', '<S-PageDown>', ':BufferLineMoveNext<cr>', opts)
keymap('n', '<leader>bp', ':BufferLinePick<cr>', opts)
keymap('n', '<leader>1', ':BufferLineGoToBuffer 1<cr>', opts)
keymap('n', '<leader>2', ':BufferLineGoToBuffer 2<cr>', opts)
keymap('n', '<leader>3', ':BufferLineGoToBuffer 3<cr>', opts)
keymap('n', '<leader>4', ':BufferLineGoToBuffer 4<cr>', opts)
keymap('n', '<leader>5', ':BufferLineGoToBuffer 5<cr>', opts)
keymap('n', '<leader>6', ':BufferLineGoToBuffer 6<cr>', opts)
keymap('n', '<leader>7', ':BufferLineGoToBuffer 7<cr>', opts)
keymap('n', '<leader>8', ':BufferLineGoToBuffer 8<cr>', opts)
keymap('n', '<leader>9', ':BufferLineGoToBuffer 9<cr>', opts)
