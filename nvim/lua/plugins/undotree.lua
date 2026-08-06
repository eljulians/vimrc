return {
  "mbbill/undotree",
  cmd = "UndotreeToggle",
  keys = {
    { "<leader>u", "<cmd>UndotreeToggle<cr>", desc = "Undo tree" },
  },
  init = function()
    -- keep undo history on disk so the tree survives restarts
    vim.o.undofile = true
  end,
}
