return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {},
  keys = {
    -- interactive pick: fuzzy-jump through the breadcrumb symbols
    { "<leader>;", function() require("dropbar.api").pick() end, desc = "Dropbar: pick symbol" },
  },
}
