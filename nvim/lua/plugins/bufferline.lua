return {
  "akinsho/bufferline.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  opts = {
    options = {
      diagnostics = false,          -- turn on later once LSP exists
      show_buffer_close_icons = false,  -- no click targets = no accidental closes
      show_close_icon = false,
      always_show_bufferline = true,
    },
  },
}
