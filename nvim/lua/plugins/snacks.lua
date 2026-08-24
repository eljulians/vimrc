return {
  "folke/snacks.nvim",
  priority = 1000, -- must load early (dashboard/notifier hook startup)
  lazy = false,
  opts = {
    bigfile = { enabled = true },   -- auto-disable heavy features on huge files
    quickfile = { enabled = true }, -- render the file before plugins finish loading
    indent = { enabled = true },    -- indent guides (replaces indent-blankline)
    notifier = { enabled = true },  -- nicer notifications (replaces nvim-notify)
    dashboard = { enabled = true }, -- startup screen when you run bare `nvim`
    zen = { enabled = true },       -- distraction-free mode
    scratch = { enabled = true },   -- throwaway scratch buffers
  },
  keys = {
    { "<leader>z", function() Snacks.zen() end, desc = "Zen mode" },
    { "<leader>.", function() Snacks.scratch() end, desc = "Scratch buffer" },
    { "<leader>n", function() Snacks.notifier.show_history() end, desc = "Notification history" },
  },
}
