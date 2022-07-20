local ok, notify = pcall(require, "notify")
if not ok then
  return
end

local config = {
  background_colour = '#000000',
  stages = "fade",
  timeout = 5000,
}

notify.setup(config)
vim.notify = notify
