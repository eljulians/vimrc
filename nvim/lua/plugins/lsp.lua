return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },
  config = function()
    require("mason").setup()
    -- give every server blink's completion capabilities
    vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

    -- show diagnostic text inline so W/E are readable
    vim.diagnostic.config({ virtual_text = true })

    -- quiet basedpyright's strict defaults (fewer bogus warnings on fine code)
    vim.lsp.config("basedpyright", {
      settings = {
        basedpyright = {
          analysis = {
            typeCheckingMode = "basic",
          },
        },
      },
    })

    -- install + auto-enable the Python server
    require("mason-lspconfig").setup({ ensure_installed = { "basedpyright" } })

    -- go-to-definition (the rest are nvim 0.11 built-in defaults, see below)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition,
          { buffer = ev.buf, desc = "Go to definition" })
      end,
    })
  end,
}
