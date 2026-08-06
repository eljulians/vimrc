return {
  "kylechui/nvim-surround",
  version = "*",
  event = "VeryLazy",
  opts = {},
  -- classic vim-surround keys: ys{motion}{char}, ds{char}, cs{old}{new}.
  -- NOTE: `ds`/`cs`/`ys` win over flash's operator-pending `s` for those
  -- sequences -- flash jumps still work from visual mode.
}
