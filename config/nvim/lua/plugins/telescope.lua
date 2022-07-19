local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end

local actions = require('telescope.actions')
local u = require('core.utils')

local default_mappings = {
  n = {
    ['Q'] = actions.smart_add_to_qflist + actions.open_qflist,
    ['q'] = actions.smart_send_to_qflist + actions.open_qflist,
    ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
    ['<s-tab>'] = actions.toggle_selection + actions.move_selection_previous,
    ['v'] = actions.file_vsplit,
    ['s'] = actions.file_split,
    ['<cr>'] = actions.file_edit,
  },
}

local opts_cursor = {
  initial_mode = 'normal',
  sorting_strategy = 'ascending',
  layout_strategy = 'cursor',
  results_title = false,
  layout_config = {
    width = 0.5,
    height = 0.4,
  },
}

local opts_vertical = {
  initial_mode = 'normal',
  sorting_strategy = 'ascending',
  layout_strategy = 'vertical',
  results_title = false,
  layout_config = {
    width = 0.3,
    height = 0.5,
    prompt_position = 'top',
    mirror = true,
  },
}

local opts_flex = {
  layout_strategy = 'flex',
  layout_config = {
    width = 0.7,
    height = 0.7,
  },
}

telescope.setup({
  defaults = {
    prompt_prefix = '🔍 ',
    selection_caret = " ",
    file_ignore_patterns = { ".git/", "node_modules" },
    dynamic_preview_title = true,
    vimgrep_arguments = {
      'rg',
      '--ignore',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--trim',
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
  pickers = {
    buffers = u.merge(opts_flex, {
      prompt_title = '✨ Search Buffers ✨',
      mappings = u.merge({
        n = {
          ['d'] = actions.delete_buffer,
        },
      }, default_mappings),
      sort_mru = true,
      preview_title = false,
    }),
    lsp_code_actions = u.merge(opts_cursor, {
      prompt_title = 'Code Actions',
    }),
    lsp_range_code_actions = u.merge(opts_vertical, {
      prompt_title = 'Code Actions',
    }),
    lsp_document_diagnostics = u.merge(opts_vertical, {
      prompt_title = 'Document Diagnostics',
      mappings = default_mappings,
    }),
    lsp_implementations = u.merge(opts_cursor, {
      prompt_title = 'Implementations',
      mappings = default_mappings,
    }),
    lsp_definitions = u.merge(opts_cursor, {
      prompt_title = 'Definitions',
      mappings = default_mappings,
    }),
    lsp_references = u.merge(opts_vertical, {
      prompt_title = 'References',
      mappings = default_mappings,
    }),
    find_files = u.merge(opts_flex, {
      prompt_title = '✨ Search Project ✨',
      mappings = default_mappings,
      hidden = true,
    }),
    diagnostics = u.merge(opts_vertical, {
      mappings = default_mappings,
    }),
    git_files = u.merge(opts_flex, {
      prompt_title = '✨ Search Git Project ✨',
      mappings = default_mappings,
      hidden = true,
    }),
    live_grep = u.merge(opts_flex, {
      prompt_title = '✨ Live Grep ✨',
      mappings = default_mappings,
    }),
    grep_string = u.merge(opts_vertical, {
      prompt_title = '✨ Grep String ✨',
      mappings = default_mappings,
    }),
  },
})

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').oldfiles, { desc = '[F]ind [R]ecently opened files' })
vim.keymap.set('n', '<leader>>fb', require('telescope.builtin').buffers, { desc = '[F]ind existing [B]uffers' })
vim.keymap.set('n', '<leader>sc', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = 'Fuzzily [S]earch in [C]urrent buffer]' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
