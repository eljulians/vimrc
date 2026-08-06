return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  keys = {
    { "<leader>t", "<cmd>FzfLua files<cr>",     desc = "Find files" },
    { "<leader>b", "<cmd>FzfLua buffers<cr>",   desc = "Buffers" },
    { "<leader>R", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
  },
  opts = function()
    return {
      actions = {
        files = {
          ["enter"] = require("fzf-lua.actions").file_edit,
        },
      },
    }
  end,
}
