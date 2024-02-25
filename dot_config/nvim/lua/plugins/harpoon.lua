return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    vim.keymap.set("n", "<leader>m", function() harpoon:list():append() end)
    vim.keymap.set("n", "<leader>ml", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    vim.keymap.set("n", "<leader>mt", ":Telescope harpoon marks<CR>", { desc = "Harpoon marks"})

    vim.keymap.set("n", "m1", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "m2", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "m3", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "m4", function() harpoon:list():select(4) end)
    vim.keymap.set("n", "m5", function() harpoon:list():select(5) end)
    vim.keymap.set("n", "m6", function() harpoon:list():select(6) end)
    vim.keymap.set("n", "m7", function() harpoon:list():select(7) end)
    vim.keymap.set("n", "m8", function() harpoon:list():select(8) end)
    vim.keymap.set("n", "m9", function() harpoon:list():select(9) end)
  end
}
