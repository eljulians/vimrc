return {
  "mfussenegger/nvim-dap",
  dependencies = {
    -- One feature, one file (same pattern as lsp.lua bundling mason/blink):
    -- neither of these means anything without nvim-dap.
    "mfussenegger/nvim-dap-python",
    {
      -- nvim-dap-view, not nvim-dap-ui: gentler single-window UI and actually
      -- maintained. Upstream pins to 1.x in its own install docs, so 2.x is
      -- assumed breaking -- lazy-lock.json holds the exact commit regardless.
      "igorlfs/nvim-dap-view",
      version = "1.*",
      opts = {
        auto_toggle = true, -- open the panel on session start, close it on exit
      },
    },
  },
  keys = {
    -- Function keys because <leader>d is trouble and <leader>b is fzf-lua.
    -- F5/F10/F11/F12 are the cross-editor convention and were all unmapped.
    { "<F5>", function() require("dap").continue() end, desc = "Debug: start / continue" },
    { "<F10>", function() require("dap").step_over() end, desc = "Debug: step over" },
    { "<F11>", function() require("dap").step_into() end, desc = "Debug: step into" },
    { "<F12>", function() require("dap").step_out() end, desc = "Debug: step out" },
    { "<leader>B", function() require("dap").toggle_breakpoint() end, desc = "Debug: toggle breakpoint" },
    -- <leader>V, not the roadmap's <leader>dv: <leader>d is trouble, so a
    -- <leader>d? mapping would make every trouble toggle wait out 'timeoutlen'.
    { "<leader>V", "<cmd>DapViewToggle<cr>", desc = "Debug: toggle view" },
  },
  config = function()
    -- debugpy via uv: the adapter runs `uv run --with debugpy python -m
    -- debugpy.adapter`, so there is nothing to install by hand and no mason
    -- package to drift. uv also resolves the project venv, so project deps are
    -- visible inside the debugger. First run downloads debugpy (needs network).
    require("dap-python").setup("uv")

    -- nvim-dap ships its signs as bare letters with texthl = "SignColumn",
    -- i.e. painted in the sign column's own muted grey -- unreadable under
    -- tokyonight. Link to the Diagnostic* groups rather than hardcoding hex:
    -- every colourscheme defines those, so this survives a theme swap.
    local function dap_highlights()
      vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "DiagnosticError" })
      vim.api.nvim_set_hl(0, "DapStopped", { link = "DiagnosticWarn" })
    end
    dap_highlights()
    -- a colourscheme does :hi clear, which drops the links above
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("dap_highlights", { clear = true }),
      callback = dap_highlights,
    })

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "DapBreakpoint" })
    vim.fn.sign_define("DapBreakpointRejected", { text = "✗", texthl = "DapBreakpoint" })
    -- linehl = debugPC is nvim-dap's own default and tokyonight defines it,
    -- so the stopped line already gets a background; keep it.
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DapStopped", linehl = "debugPC" })
  end,
}
