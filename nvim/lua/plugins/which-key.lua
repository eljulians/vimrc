return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- wait a beat before popping up, so fast typing never sees it
    delay = 400,
    spec = {
      -- group names shown in the popup for our prefixes
      { "<leader>g", group = "git" },
      { "<leader>s", group = "session (+sv=source vimrc)" },
      { "<leader>a", group = "avante (AI)" },
    },
  },
}
