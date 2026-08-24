return {
  "MagicDuck/grug-far.nvim",
  -- Upstream notes it defers its own requires, so it's lazy regardless; cmd +
  -- keys keep it off the startup path anyway.
  cmd = { "GrugFar", "GrugFarWithin" },
  keys = {
    { "<leader>S", "<cmd>GrugFar<cr>", desc = "Search & replace (project)" },
    -- From visual mode :GrugFar pre-fills the search with the selection, which
    -- is the common case (grab a symbol, replace it everywhere).
    -- :GrugFarWithin is the other one -- replace only *inside* the selected
    -- range -- left on the command for when it's actually wanted.
    { "<leader>S", "<cmd>GrugFar<cr>", mode = "x", desc = "Search & replace (selection as term)" },
  },
  -- No required options. Buffer-local actions sit on <localleader>, which is
  -- unset here and so falls back to `\` -- see README for the real keys.
  opts = {},
}
