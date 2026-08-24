return {
  "esmuellert/codediff.nvim",
  -- Pinned hard on purpose: upstream shipped v2.63.1 through v2.66 in a single
  -- day. lazy-lock.json is the pin; don't run a bare update without reading
  -- the release notes.
  cmd = "CodeDiff",
  keys = {
    { "<leader>C", "<cmd>CodeDiff<cr>", desc = "Diff (working tree)" },
    { "<leader>ch", "<cmd>CodeDiff history<cr>", desc = "Diff: file history" },
  },
  opts = {
    keymaps = {
      view = {
        -- Two defaults collided with existing global maps, so they move here.
        -- These are buffer-local to the diff tab, so the originals keep
        -- working everywhere else -- but a key that silently means two things
        -- depending on the tab is worse than a key you had to learn once.
        stage_hunk = "<leader>hS",     -- default <leader>hs = our :ls + :sb split
        toggle_explorer = "<leader>E", -- default <leader>b  = fzf-lua buffers
        -- Deliberately left at codediff's defaults, shadowing only inside the
        -- diff tab: `-` (oil parent dir), `]c`/`[c` (gitsigns hunk motion).
        -- Neither makes sense in a diff tab, so the shadow is the useful thing.
      },
    },
  },
}
