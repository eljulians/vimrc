return {
  "nvim-treesitter/nvim-treesitter-context",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  event = { "BufReadPre", "BufNewFile" },
  main = "treesitter-context", -- module name differs from the repo name
  opts = {
    max_lines = 3,           -- keep the sticky header short
    multiline_threshold = 1, -- collapse multi-line signatures to one line
  },
}
