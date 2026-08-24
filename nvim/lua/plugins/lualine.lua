return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    sections = {
      -- LSP progress, replacing fidget.nvim (item 10). 0.12 tracks progress
      -- messages natively; lualine's opts = {} used to overwrite 'statusline'
      -- wholesale and throw that away. Returns "" when idle and e.g. "45%(2)"
      -- while N jobs run -- the doubled %% in the native output is deliberate,
      -- lualine passes it through and the statusline parser renders one %.
      -- Only this section is listed; lualine keeps its defaults for the rest.
      -- Not adding vim.diagnostic.status: lualine_b already has "diagnostics".
      lualine_x = {
        function()
          return vim.ui.progress_status()
        end,
        "encoding",
        "fileformat",
        "filetype",
      },
    },
  },
}
