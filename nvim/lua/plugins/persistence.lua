return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = {},
  -- <leader>q* and <leader>sv are taken by vimrc_basic, hence s-prefix
  keys = {
    { "<leader>sl", function() require("persistence").load() end, desc = "Restore session for this dir" },
    { "<leader>sL", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
  },
}
