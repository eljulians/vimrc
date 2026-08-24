return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- needs markdown + markdown_inline parsers (installed)
    "nvim-tree/nvim-web-devicons",
  },
  lazy = false, -- load at startup so it's always ready (rendering is still gated to file_types)
  opts = {
    file_types = { "markdown", "Avante" },
  },
}
