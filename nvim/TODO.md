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

- [x] **Commit everything** — nvim/, scripts/install_nvim.sh still untracked!
- [x] treesitter (`branch = "master"`, the 0.11-compatible frozen branch)
- [x] gitsigns (replaces gitgutter)
- [x] which-key (live keybinding reminder)
- [x] flash.nvim (motion)
- [x] oil.nvim (installed 2026-08-06; nerdtree verdict pending trial — see Open decisions)

## Round 2 (2026-08-06)

- [x] nvim-surround (revives vim-surround from legacy config; user never used it, wants to learn)
- [x] persistence.nvim (replaces vim-obsession; `<leader>sl`/`<leader>sL`)
- [x] mini.pairs (auto-close brackets/quotes)
- [x] trouble.nvim (diagnostics list; `<leader>d`)
- [x] undotree (`<leader>u`; also enabled persistent undofile)

## Training sessions (no installs, just learning)

- [ ] vim text objects (`iw`, `i"`, `i(`, `ip`, inner vs around) — never used in 10 yrs; prerequisite for getting real value out of nvim-surround; later: treesitter text objects (`if` = inside function)

## Spaceship 🚀

Full 2026 blueprint in [SPACESHIP.md](SPACESHIP.md) (researched 2026-08-06 by agent swarm; T1/T2/T3 + AI path + "avoid" list).

Decisions (2026-08-06):
- ✅ **Upgraded to Neovim 0.12.4** (2026-08-06, via home-manager). Config verified clean.
- **Pace: one plugin at a time, under supervision, tracked here.** Not batched.
- **Phase 0 config items parked (2026-08-11).** `/install-next` now serves plugin items only; the 🆓 config
  chores (items 2–7, 12) are `⏸` and reachable with `/install-next config`. Numbers never change — items
  cross-reference each other, so reordering is parking, not renumbering.
- **AI auth constraint:** no API key available. Must ride already-authenticated CLIs (`claude` at work, `codex`+ChatGPT personally). Goal = look like Cursor. Key-free/Codex/ACP path under re-research.

- [x] upgrade nvim 0.11.6 → 0.12.4 (done by user 2026-08-06; verified boots clean, LSP+treesitter OK)
- [x] AI: installed **avante.nvim** (2026-08-06) — ACP-only, key-free, driving the logged-in `claude` CLI via the official `claude-agent-acp` adapter (the ToS-safer `acp-claude-code` bridge crashed under Node 24 / current claude-code pkg, so we use the Agent-SDK adapter = the ToS soft-spot). No API key, rides the subscription. Provider-agnostic: Codex leg on the personal box via `:AvanteSwitchProvider`. Verified boots + wired; first `:AvanteAsk` is the interactive test. NO key-free Tab ghost-text — blink.cmp stays as the fallback.
- [x] **item 1: `vimrc_basic` correctness pass** (2026-08-11) — six verified bugs in the file that's sourced
      before lazy.nvim: `<C-J>` double-mapped (split-down navigation was dead; break-line moved to
      `<leader>j`), `ignorecase` without `smartcase`, `set`→`setlocal` in the .py/.js autocmds (`sw=2` was
      leaking into every later buffer), visual `<leader>c` copied the whole file (deleted), `updatetime`
      4000→250 so the agent-edited-file auto-reload actually fires, `filetype off` relic → explicit
      `filetype plugin indent on`. Plus `scrolloff=8`, `confirm`, `timeoutlen=400`, legacy-only
      `colorscheme`/`highlight` guarded behind `if !has('nvim')`, dead lines dropped.
- [x] **item 8: mini.pairs org rename** (2026-08-11) — spec said `echasnovski/mini.pairs`, which now only
      resolves via GitHub redirect; pinned to the real `nvim-mini/mini.pairs`. `Lazy! sync` rewrote the
      clone's origin URL. Same commit, no lockfile change (lazy keys by plugin name, not owner).
- [x] **item 9: dropped mbbill/undotree for native `nvim.undotree`** (2026-08-11) — 0.12 bundles an
      undo-tree browser; moving the cursor in it changes the undo state live, where mbbill's needed `Enter`.
      `undofile = true` moved out of the deleted spec into `init.lua` first, so persistent undo never went
      unowned. `<leader>u` kept, now `:Undotree`.
- [x] **item 10: dropped fidget.nvim for native LSP progress in lualine** (2026-08-11) — 0.12 tracks
      progress messages natively (`vim.ui.progress_status()`), but lualine's `opts = {}` overwrote
      `'statusline'` wholesale and threw it away. Now a component in `lualine_x`; shows `45%(2)` while
      indexing, empty when idle. Skipped the item's `vim.diagnostic.status` suggestion — lualine's default
      `lualine_b` already carries `diagnostics`, so it would have been a duplicate.
- [x] **item 11: removed bufferline.nvim** (2026-08-11) — re-verified 🧊: last push 2025-01-14, **0 commits
      in 2026**, 103 open issues, not archived so it looks fine from outside. Pure decoration given
      `<C-N>`/`<C-P>`/`<leader>b`/harpoon, and it was the 4th bar around the code. Reclaims a screen row
      (`showtabline` back to 1, `tabline` empty). devicons kept — lualine/trouble/oil/render-markdown need it.
- [x] **item 13: installed codediff.nvim** (2026-08-11) — first genuinely new plugin of the spaceship round.
      Multi-file diffs in a tab (`<leader>C`), history (`<leader>ch`), 3-way merge. Fills the gap gitsigns
      never covered: reviewing a whole multi-file change without `git diff | less` in another pane. Pinned to
      `e08a35a5` (v2.67.0, released the same day) — upstream ships several releases per day, so never bare-update.
      Two of its defaults collided and were moved: `stage_hunk` → `<leader>hS` (was `<leader>hs`, our split),
      `toggle_explorer` → `<leader>E` (was `<leader>b`, fzf-lua — **the roadmap missed this one**).
      Note: loads a prebuilt C library via FFI (`libvscode_diff_2.67.0.so`, downloaded from GitHub releases).
- [x] **item 14: installed nvim-dap + nvim-dap-python + nvim-dap-view** (2026-08-11) — real Python
      debugging: `<leader>B` breakpoint, `F5` start/continue, `F10`/`F11`/`F12` over/into/out, `<leader>V`
      panel. `debugpy` comes from `uv run --with debugpy` (verified: fetches 1.8.21), so no mason package
      and nothing to install by hand. dap-view pinned to `1.*` per upstream's own advice (resolved v1.2.1),
      `auto_toggle = true` so the panel follows the session. Used `<leader>V` instead of the roadmap's
      `<leader>dv` — `<leader>d` is trouble, so any `<leader>d?` mapping would make trouble wait out
      `timeoutlen`. The `<leader>G` ipdb mapping in `vimrc_basic` is deliberately kept (still the fastest
      route for odd entrypoints).
      **Follow-up same day:** breakpoint marker was invisible — nvim-dap ships `text = "B "` with
      `texthl = "SignColumn"`, i.e. grey-on-grey under tokyonight. Redefined all five signs with glyphs
      (`●◆◇✗▶`) and linked the highlights to `DiagnosticError`/`DiagnosticWarn`, re-applied on a
      `ColorScheme` autocmd because `:hi clear` drops them. Same trap as parked item 5 (ExtraWhitespace).
- [x] **item 15: installed grug-far.nvim** (2026-08-24) — project find/replace in an editable buffer,
      `<leader>S` (visual mode pre-fills the selection). Closes the gap after `<leader>R`: fzf-lua found
      matches, nothing changed them without leaving nvim. Upstream is the cleanest tracker in the whole
      audit — **0** open issues, pushed 2026-08-13. Actions are on `<localleader>`, unset here so it falls
      back to `\` (`\r` replace, `\s` sync hand-edits, `\c` close). rg 15.1.0 exceeds its >=15 recommendation.
      Also filled a README gap while in there: the fzf-lua picker table never documented `Ctrl-j`/`Ctrl-k`.
- [ ] then the remaining SPACESHIP.md items, one at a time

## Later / maybe

- [ ] conform.nvim (in-editor formatting — skipped: pre-commit/CI already run ruff, revisit only if manually formatting in terminal becomes a habit)
- [ ] evaluate snacks.nvim once core is stable

## Open decisions

- [ ] nerdtree: keep, or does oil.nvim replace it? (pending oil trial)
- [x] **treesitter: migrated `master` → `main` (2026-08-07)** — fixes the 0.12 injection crash. New setup in `treesitter.lua`: `install()` in config + `vim.treesitter.start()` FileType autocmd, no `.configs`. Needs the `tree-sitter` CLI (cargo-installed now; added to `home.nix` → `home-manager switch` to make it permanent/tracked, then optionally `cargo uninstall tree-sitter-cli`). render-markdown + treesitter-context re-enabled, verified.
- [ ] legacy vimrc_extended + install_dependencies.sh have old uncommitted edits (pre-migration, from ~2020-era work) — commit or discard, separately from nvim work
- [ ] set `cleanupPeriodDays` in ~/.claude/settings.json so session transcripts stop being deleted after 30 days
