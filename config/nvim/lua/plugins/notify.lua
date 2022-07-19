local ok, notify = pcall(require, "notify")
if not ok then
  return
end

local config = {
  stages = "fade",
  timeout = 5000,
}

notify.setup(config)
vim.notify = notify
