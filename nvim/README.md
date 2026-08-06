# Neovim config

Fresh nvim build (0.11.x), not a port of the legacy vim setup.

- `init.lua` sources `../vimrc_basic` (shared with legacy vim), then bootstraps lazy.nvim.
- One plugin = one file in `lua/plugins/`. Versions pinned in `lazy-lock.json`.
- `scripts/install_nvim.sh` symlinks `~/.config/nvim` -> this dir. Nothing is hand-placed under `~/.config`.
- `vimrc_extended` is **not** used here; legacy vim keeps working untouched.

**Rule: every plugin added gets a row in the table below plus its keys in the relevant section. Keys only, no prose.**

Roadmap / what's next: [TODO.md](TODO.md).

## What's installed

| Plugin | Replaces | What it is |
|---|---|---|
| lazy.nvim | Vundle | plugin manager, self-bootstrapping |
| tokyonight.nvim | `desert` | colorscheme |
| fzf-lua | fzf.vim | fuzzy finder (files, buffers, grep) |
| bufferline.nvim | vim-buftabline | the buffer bar along the top — display only, no keys of its own |
| lualine.nvim | custom statusline + powerline | the status line along the bottom |
| nvim-lspconfig + mason | jedi-vim | LSP client + server installer; `basedpyright` for Python |
| blink.cmp | supertab | autocompletion popup, fed by the LSP |
| nvim-web-devicons | — | icons, dependency of bufferline/lualine |

## fzf-lua

Leader is `<Space>`. These three mirror the old fzf.vim bindings, so muscle memory carries over.

| Key | Does |
|---|---|
| `<leader>t` | find files |
| `<leader>b` | switch buffer |
| `<leader>R` | live grep |

Inside the picker:

| Key | Does |
|---|---|
| `Enter` | open (always edits, even with multiple selected) |
| `Tab` | multi-select |
| `Ctrl-s` / `Ctrl-v` / `Ctrl-t` | open in split / vsplit / tab |
| `Alt-q` | send selection to quickfix |
| `Ctrl-f` / `Ctrl-b` | half page down / up |
| `Alt-a` | toggle all |
| `Alt-i` / `Alt-h` | toggle gitignored / hidden files |
| `F4` | toggle preview |
| `Shift-Down` / `Shift-Up` | scroll preview |
| `Ctrl-x` | delete buffer (buffers picker only) |
| `Ctrl-z` | abort |
| `F1` | show all keys |

The `Enter` override exists on purpose: by default multi-select dumps into a quickfix list instead of opening buffers.

## LSP

Mostly nvim 0.11 built-ins — no plugin needed, which is why `lsp.lua` maps almost nothing.

| Key | Does |
|---|---|
| `gd` | go to definition (the one we map ourselves) |
| `K` | hover docs |
| `grn` | rename symbol |
| `gra` | code action |
| `grr` | references |
| `gri` | implementation |
| `grt` | type definition |
| `gO` | symbols in this file |
| `Ctrl-s` (insert) | signature help |
| `]d` / `[d` | next / previous diagnostic |
| `]D` / `[D` | last / first diagnostic |
| `Ctrl-w d` | show diagnostic in a float |

| Command | Does |
|---|---|
| `:checkhealth vim.lsp` | is a server attached, and which |
| `:LspRestart` | reload after config changes |
| `:Mason` | installed servers; `i` install, `X` uninstall |

Diagnostics show inline (`virtual_text`); basedpyright runs in `basic` mode to cut strict-mode noise.

## Completion (blink.cmp, `super-tab` preset)

| Key | Does |
|---|---|
| `Tab` | accept selected (or jump snippet placeholder) |
| `Shift-Tab` | previous snippet placeholder |
| `Ctrl-n` / `Ctrl-p` | next / previous item (also `Down` / `Up`) |
| `Ctrl-space` | show menu / toggle docs |
| `Ctrl-b` / `Ctrl-f` | scroll docs |
| `Ctrl-k` | toggle signature |
| `Ctrl-e` | cancel |

Sources: LSP, paths, current buffer.

## Buffer bar / status line

No keys of their own. Buffers are navigated with the `vimrc_basic` mappings: `Ctrl-N` next, `Ctrl-P` previous, `<leader>D` close current.

## Managing plugins

| Command | Does |
|---|---|
| `:Lazy` | plugin UI — `S` sync, `U` update, `X` clean, `?` help |
| `:Lazy sync` | install/remove to match the specs, then rewrite `lazy-lock.json` |

To add a plugin: create `lua/plugins/<name>.lua` returning its spec, restart nvim, commit the spec **and** the updated `lazy-lock.json`.
