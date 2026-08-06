# Neovim config

Fresh nvim build (0.12.x), not a port of the legacy vim setup.

- `init.lua` sources `../vimrc_basic` (shared with legacy vim), then bootstraps lazy.nvim.
- One plugin = one file in `lua/plugins/`. Versions pinned in `lazy-lock.json`.
- `scripts/install_nvim.sh` symlinks `~/.config/nvim` -> this dir. Nothing is hand-placed under `~/.config`.
- `vimrc_extended` is **not** used here; legacy vim keeps working untouched.

**Rule: every plugin added gets a row in the table below (linked to its repo) plus a section: one line on what it's about, then keys. No further prose.**

Roadmap / what's next: [TODO.md](TODO.md).

## What's installed

| Plugin | Replaces | What it is |
|---|---|---|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Vundle | plugin manager, self-bootstrapping |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | `desert` | colorscheme |
| [fzf-lua](https://github.com/ibhagwan/fzf-lua) | fzf.vim | fuzzy finder (files, buffers, grep) |
| [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) | vim-buftabline | the buffer bar along the top — display only, no keys of its own |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | custom statusline + powerline | the status line along the bottom |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason](https://github.com/mason-org/mason.nvim) | jedi-vim | LSP client + server installer; `basedpyright` for Python |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | regex syntax highlighting, vim-syntax-extra | real syntax trees: better highlighting + indentation. No keys. `master` branch (frozen, 0.11-only) |
| [blink.cmp](https://github.com/saghen/blink.cmp) | supertab | autocompletion popup, fed by the LSP |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | vim-gitgutter | git change markers in the margin + hunk operations |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | this README, partly | pause mid-keypress (e.g. after `<Space>`) → popup of every binding that continues from there. No keys of its own |
| [flash.nvim](https://github.com/folke/flash.nvim) | counting `10j`, most `/foo` navigation | labeled jump: `s` + 2 chars + label key → cursor lands there |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | nerdtree (on trial), netrw | a directory is a text buffer: edit lines = rename/delete/create files |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | vim-surround (legacy vim had it) | add/change/delete surrounding quotes, brackets, tags |
| [persistence.nvim](https://github.com/folke/persistence.nvim) | vim-obsession | auto-saves your session per directory; restore buffers/splits as you left them |
| [mini.pairs](https://github.com/echasnovski/mini.pairs) | — | type `(` get `()`, auto-closes quotes/brackets |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | chasing `]d` blind | all diagnostics in one navigable bottom panel |
| [undotree](https://github.com/mbbill/undotree) | — | browse vim's full undo history as a tree, recover overwritten states |
| [avante.nvim](https://github.com/yetone/avante.nvim) | (the AI layer) | Cursor-style AI sidebar + inline diffs; key-free via your logged-in `claude` CLI over ACP |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | — | icons, dependency of bufferline/lualine |

## Finding things ([fzf-lua](https://github.com/ibhagwan/fzf-lua))

Type a few letters, fuzzy-match against every file/buffer/line in the project, hit enter. How you open anything that isn't already on screen.

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

## Code intelligence (LSP — [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason](https://github.com/mason-org/mason.nvim))

A language server (basedpyright for Python) reads your code and answers questions: where is this defined, who calls it, what's wrong on this line. What jedi-vim did, but for any language.

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

## Completion ([blink.cmp](https://github.com/saghen/blink.cmp), `super-tab` preset)

The popup that suggests code as you type in insert mode, fed by the LSP. Old supertab, smarter.

| Key | Does |
|---|---|
| `Tab` | accept selected (or jump snippet placeholder) |
| `Shift-Tab` | previous snippet placeholder |
| `Ctrl-n` / `Ctrl-p` | next / previous item (also `Down` / `Up`) |
| `Ctrl-space` | show menu / toggle docs |
| `Ctrl-b` / `Ctrl-f` | scroll docs |
| `Ctrl-k` | toggle signature |
| `Ctrl-e` | cancel |

Sources: LSP, paths, current buffer. Disabled inside avante's AI prompt buffers (`Avante*`
filetypes) — you're typing English there, not code.

## Motion ([flash.nvim](https://github.com/folke/flash.nvim))

Jump the cursor to anything you can *see* in ~3 keystrokes, instead of counting lines or spamming `w`/`/`. Point with your eyes, type 2 chars of the target, press the label that appears.

| Key | Does |
|---|---|
| `s` + 2 chars | labels appear on every match on screen → press a label to jump there |
| `S` | select the treesitter node under the cursor; repeat `S`/`s` to grow, `;`/`,` also work |
| `Esc` | bail out |

Shadows vim's native `s`/`S` — use `cl`/`cc` for those (they're synonyms anyway).
Enhanced `f`/`t` and `/` integration exist but are off; enable in flash.lua if wanted.

## Files ([oil.nvim](https://github.com/stevearc/oil.nvim))

File management with vim editing instead of a tree sidebar: the directory opens as a normal buffer where each line is a file — edit the text, `:w`, and the filesystem changes to match.

| Key | Does |
|---|---|
| `-` | open the current file's directory (again = go up a level) |
| `Enter` | open file / descend into directory |
| edit a line + `:w` | rename that file |
| `dd` + `:w` | delete it |
| `o` + type a name + `:w` | create it (end with `/` for a directory) |
| any vim op + `:w` | works: `yy`/`p` copies a file, visual-select + `d` deletes many |
| `Ctrl-c` | close without applying |

Every `:w` shows a confirmation of the pending filesystem operations before running them.

## Git ([gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim))

Shows what you've changed since the last commit, in the margin, live — and lets you stage/discard/inspect each change block without leaving the buffer.

Margin markers: `┃` changed, `+` added, `_` deleted. A "hunk" = one block of changed lines.

| Key | Does |
|---|---|
| `]c` / `[c` | next / previous hunk |
| `<leader>gs` | stage hunk (again to unstage) |
| `<leader>gr` | reset hunk — throw away those changes |
| `<leader>gp` | preview hunk diff in a float |
| `<leader>gb` | blame current line |

(`<leader>g*` because `<leader>hs` was already taken by the split mappings in vimrc_basic.)

## Surround ([nvim-surround](https://github.com/kylechui/nvim-surround))

Operations on the quotes/brackets/tags *around* something: add them, change them, remove them.

| Key | Does |
|---|---|
| `ysiw"` | wrap word in `"` (`ys` + motion + char) |
| `cs"'` | change surrounding `"` to `'` |
| `ds(` | delete surrounding `(` `)` |
| `S"` (visual) | wrap selection |

These two-key sequences (`ys`/`ds`/`cs`) take priority over flash's operator `s` — flash jumps still work from visual mode.

## Sessions ([persistence.nvim](https://github.com/folke/persistence.nvim))

Auto-saves the editor state (buffers, splits, cursor) per directory on exit. Nothing to do while working — only restoring is manual.

| Key | Does |
|---|---|
| `<leader>sl` | restore the session for this directory |
| `<leader>sL` | restore whatever session was last, regardless of directory |

## Diagnostics list ([trouble.nvim](https://github.com/folke/trouble.nvim))

Collects every warning/error the LSP knows about into one bottom panel instead of hunting margin markers file by file.

| Key | Does |
|---|---|
| `<leader>d` | toggle the panel |
| `j`/`k` + `Enter` | jump to the diagnostic |
| `q` | close |

## Undo history ([undotree](https://github.com/mbbill/undotree))

Vim keeps every past state of a buffer, including branches you "overwrote" by undoing then typing. This shows the whole tree and lets you jump to any state. Undo history persists across restarts (`undofile`).

| Key | Does |
|---|---|
| `<leader>u` | toggle the tree panel |
| `j`/`k` + `Enter` | preview / jump to a state |
| `q` | close |

## Auto-pairs ([mini.pairs](https://github.com/echasnovski/mini.pairs))

Typing `(`, `[`, `{`, `"`, `'` inserts the closing half; `Backspace` between a pair removes both. No keys to learn.

## Buffer bar / status line ([bufferline](https://github.com/akinsho/bufferline.nvim) / [lualine](https://github.com/nvim-lualine/lualine.nvim))

Pure display: open buffers as tabs along the top, mode/file/position along the bottom. No keys of their own. Buffers are navigated with the `vimrc_basic` mappings: `Ctrl-N` next, `Ctrl-P` previous, `<leader>D` close current.

## AI ([avante.nvim](https://github.com/yetone/avante.nvim))

Cursor-style AI: a sidebar that chats about your code and proposes edits as accept/reject diffs.
Runs **key-free** by driving your logged-in `claude` CLI over ACP (the `claude-agent-acp` adapter) —
your Claude subscription, no API key. Provider-agnostic **and portable**: `avante.lua` auto-picks the agent CLI installed on the
machine — `claude` here → `claude-code`; `codex` on the personal box → `codex` (riding the ChatGPT
subscription). Both legs are defined; override any time with `:AvanteSwitchProvider`.

| Key | Does |
|---|---|
| `<leader>aa` | ask avante about the current file / selection |
| `<leader>ae` | edit the selected code with a prompt |
| `<leader>at` | toggle the sidebar |
| `<leader>af` | focus the sidebar |
| `<leader>ar` | refresh |
| `<leader>aS` | stop generating |
| `<leader>aM` / `<leader>am` | pick the ACP model / mode |

In the sidebar:

| Key | Does |
|---|---|
| `<CR>` / `<C-s>` | submit (normal / insert mode) |
| `@` | add a file to the context |
| `<Tab>` | switch between input and result windows |
| `a` / `A` | apply the change at cursor / apply all |
| `co` / `ct` / `cb` | on a conflict: keep ours / theirs / both |
| `]x` / `[x` | next / previous change |

Commands: `:AvanteAsk`, `:AvanteSwitchProvider <name>`. **Never** enable a direct-API provider with
`auth_type="max"` (User-Agent-spoofing ban-evasion) — ACP only. First use: restart nvim, then `<leader>aa`.

## Managing plugins ([lazy.nvim](https://github.com/folke/lazy.nvim))

Installs whatever `lua/plugins/*.lua` declares, pins versions in `lazy-lock.json`.

| Command | Does |
|---|---|
| `:Lazy` | plugin UI — `S` sync, `U` update, `X` clean, `?` help |
| `:Lazy sync` | install/remove to match the specs, then rewrite `lazy-lock.json` |
| `:TSInstallInfo` | which treesitter parsers are installed |
| `:TSUpdate` | update parsers (also runs on plugin update) |

To add a plugin: create `lua/plugins/<name>.lua` returning its spec, restart nvim, commit the spec **and** the updated `lazy-lock.json`.
