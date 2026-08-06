return {
  "nvim-treesitter/nvim-treesitter",
  -- master = the frozen, stable branch (still the safe default on 0.12). Since we're
  -- now on 0.12.4 the `main` rewrite is available -- migrating is an optional, tracked
  -- upgrade (see TODO.md), not done yet.
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
