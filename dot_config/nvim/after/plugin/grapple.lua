vim.keymap.set("n", "<leader>a", require("grapple").toggle)
vim.keymap.set("n", "<C-e>", require("grapple").popup_tags)

vim.keymap.set("n", "<C-h>", function() require("grapple").select({ key = 1 }) end)
vim.keymap.set("n", "<C-t>", function() require("grapple").select({ key = 2 }) end)
vim.keymap.set("n", "<C-n>", function() require("grapple").select({ key = 3 }) end)
vim.keymap.set("n", "<C-s>", function() require("grapple").select({ key = 4 }) end)
