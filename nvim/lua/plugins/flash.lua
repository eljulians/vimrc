return {
  "folke/flash.nvim",
  event = "VeryLazy",
  opts = {},
  -- NOTE: this shadows vim's native `s` (synonym for `cl`) and `S` (synonym
  -- for `cc`). Deliberate: the synonyms are redundant, the motions are not.
  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter select" },
  },
}
