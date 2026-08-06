return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- not lazy: oil takes over `nvim <directory>` from netrw, so it must be
  -- loaded at startup for that to work
  lazy = false,
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
  },
  opts = {
    -- confirm before applying the edits (renames/deletes) -- training wheels,
    -- set skip_confirm_for_simple_edits = true once trusted
    view_options = {
      show_hidden = true,
    },
  },
}
