return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  keys = {
    { "<leader>d", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics list" },
  },
  opts = {},
}
