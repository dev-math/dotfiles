local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
  [[   ____     __       _                            /\/|           __                                ]],
  [[  / __ \   / _|     | |                          |/\/           /_/                                ]],
  [[ | |  | | | |_ _   _| |_ _   _ _ __ ___    _ __   __ _  ___     ___   _ __   _____   _____         ]],
  [[ | |  | | |  _| | | | __| | | | '__/ _ \  | '_ \ / _` |/ _ \   / _ \ | '_ \ / _ \ \ / / _ \        ]],
  [[ | |__| | | | | |_| | |_| |_| | | | (_) | | | | | (_| | (_) | |  __/ | | | | (_) \ V / (_) |  _    ]],
  [[  \____/  |_|  \__,_|\__|\__,_|_|  \___/  |_| |_|\__,_|\___/   \___| |_| |_|\___/ \_/ \___/  ( )   ]],
  [[     __                                           _ _                           _ _          |/    ]],
  [[    /_/                                          | | |                         | | |               ]],
  [[    ___   _   _ _ __ ___   __ _   _ __ ___  _   _| | |__   ___ _ __  __   _____| | |__   __ _      ]],
  [[   / _ \ | | | | '_ ` _ \ / _` | | '_ ` _ \| | | | | '_ \ / _ \ '__| \ \ / / _ \ | '_ \ / _` |     ]],
  [[  |  __/ | |_| | | | | | | (_| | | | | | | | |_| | | | | |  __/ |     \ V /  __/ | | | | (_| |  _  ]],
  [[   \___|  \__,_|_| |_| |_|\__,_| |_| |_| |_|\__,_|_|_| |_|\___|_|      \_/ \___|_|_| |_|\__,_| (_) ]],
}
dashboard.section.buttons.val = {
	dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
	dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("r", "  Recent files", ":Telescope oldfiles <CR>"),
	dashboard.button("t", "  Find text", ":Telescope live_grep <CR>"),
	dashboard.button("c", "  Config", ":e ~/.config/nvim/init.lua <CR>"),
	dashboard.button("q", "  Quit", ":qa<CR>"),
}
-- 
local function footer()
-- NOTE: requires the fortune-mod package to work
	-- local handle = io.popen("fortune")
	-- local fortune = handle:read("*a")
	-- handle:close()
	-- return fortune
	return "Neovim"
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
-- vim.cmd([[autocmd User AlphaReady echo 'ready']])
alpha.setup(dashboard.opts)
