return {
  "nvim-treesitter/nvim-treesitter",
  -- MAIN branch: the 0.12 rewrite. The old `master` branch is frozen and crashes on
  -- 0.12 injection/predicate parsing. `main` is a from-scratch rewrite -- no more
  -- `nvim-treesitter.configs`, no `ensure_installed`/`highlight`/`indent` blocks, and
  -- it does NOT support lazy-loading. Requires the `tree-sitter` CLI on PATH.
  branch = "main",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    -- Ensure our parsers are installed (async; no-op once present, so cheap on every start).
    require("nvim-treesitter").install({
      "python", "lua", "vim", "vimdoc", "bash",
      "json", "yaml", "markdown", "markdown_inline", "terraform",
    })

    -- Highlighting is opt-in on `main`: start it per-buffer when a parser exists.
    -- (Indentation via treesitter is experimental on `main`; left off for now --
    -- vimrc_basic's PEP8 autoindent handles Python. Add an indentexpr here later.)
    vim.api.nvim_create_autocmd("FileType", {
      group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
      callback = function(args)
        local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
        if not lang then return end
        local ok, added = pcall(vim.treesitter.language.add, lang)
        if ok and added then
          vim.treesitter.start(args.buf, lang)
        end
      end,
    })
  end,
}
