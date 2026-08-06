# Migration checklist

State of the vim → nvim migration. Update in the same commit as the change itself.
Done items stay checked, don't delete — this doubles as the "what did we do" log.

## Done (2026-07-02)

- [x] lazy.nvim bootstrap, config tracked in repo, install via scripts/install_nvim.sh
- [x] tokyonight (colorscheme)
- [x] fzf-lua (`<leader>t/b/R`)
- [x] bufferline + lualine
- [x] LSP: basedpyright via mason, blink.cmp completion
- [x] README.md cheat sheet (2026-08-06)

## Next (in order)

- [ ] **Commit everything** — nvim/, scripts/install_nvim.sh still untracked!
- [ ] treesitter (`branch = "master"`, the 0.11-compatible frozen branch)
- [ ] gitsigns (replaces gitgutter)
- [ ] which-key (live keybinding reminder)
- [ ] flash.nvim (motion)
- [ ] conform.nvim (formatters — replaces old ale_fixers)
- [ ] oil.nvim (try it; if it sticks, closes the nerdtree question)

## Later / maybe

- [ ] trouble.nvim (diagnostics list)
- [ ] mini.pairs or nvim-autopairs
- [ ] undotree
- [ ] evaluate snacks.nvim once core is stable

## Open decisions

- [ ] nerdtree: keep, or does oil.nvim replace it? (pending oil trial)
- [ ] treesitter: move to `main` rewrite when on nvim 0.12
- [ ] legacy vimrc_extended + install_dependencies.sh have old uncommitted edits (pre-migration, from ~2020-era work) — commit or discard, separately from nvim work
- [ ] set `cleanupPeriodDays` in ~/.claude/settings.json so session transcripts stop being deleted after 30 days
