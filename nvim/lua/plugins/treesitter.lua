return {
  "nvim-treesitter/nvim-treesitter",
  -- master = the frozen, nvim 0.11-compatible branch (main is a rewrite
  -- requiring 0.12+). Revisit when upgrading nvim -- tracked in TODO.md.
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPre", "BufNewFile" },
  main = "nvim-treesitter.configs",
  opts = {
    ensure_installed = {
      "python", "lua", "vim", "vimdoc", "bash",
      "json", "yaml", "markdown", "markdown_inline", "terraform",
    },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
