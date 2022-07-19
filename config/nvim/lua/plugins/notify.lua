local config = {
  stages = "fade",
  timeout = 5000,
}

local notify = require("notify")
notify.setup(config)
vim.notify = notify
