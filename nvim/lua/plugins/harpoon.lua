return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup()

    -- <leader>a is avante, <leader>h* is splits (vimrc_basic) -> use H / m / 1-4
    vim.keymap.set("n", "<leader>H", function() harpoon:list():add() end, { desc = "Harpoon: pin file" })
    vim.keymap.set("n", "<leader>m", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: menu" })
    for i = 1, 4 do
      vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon: file " .. i })
    end
  end,
}
