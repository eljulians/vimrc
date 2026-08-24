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
| [grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim) | ⛔ quicker.nvim, 🧊 nvim-spectre | project-wide find & replace in an editable buffer |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | custom statusline + powerline | the status line along the bottom |
| [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) + [mason](https://github.com/mason-org/mason.nvim) | jedi-vim | LSP client + server installer; `basedpyright` for Python |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | regex syntax highlighting, vim-syntax-extra | real syntax trees: better highlighting. No keys. `main` branch (0.12 rewrite); highlight is opt-in via a FileType autocmd; needs the `tree-sitter` CLI |
| [nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context) | — | sticky header showing the enclosing class/def as you scroll (VS Code sticky-scroll). No keys |
| [blink.cmp](https://github.com/saghen/blink.cmp) | supertab | autocompletion popup, fed by the LSP |
| [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) | vim-gitgutter | git change markers in the margin + hunk operations |
| [codediff.nvim](https://github.com/esmuellert/codediff.nvim) | `git diff \| less` in another pane, 🧊 diffview.nvim | VSCode's diff engine via FFI: multi-file side-by-side diffs, history browser, 3-way merge |
| [nvim-dap](https://github.com/mfussenegger/nvim-dap) + [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) | the `ipdb.set_trace()` habit | real breakpoint debugging; `debugpy` supplied on demand by `uv` |
| [nvim-dap-view](https://github.com/igorlfs/nvim-dap-view) | ⛔ nvim-dap-ui | the debugger panel: scopes, stack, breakpoints, watches, REPL |
| [which-key.nvim](https://github.com/folke/which-key.nvim) | this README, partly | pause mid-keypress (e.g. after `<Space>`) → popup of every binding that continues from there. No keys of its own |
| [flash.nvim](https://github.com/folke/flash.nvim) | counting `10j`, most `/foo` navigation | labeled jump: `s` + 2 chars + label key → cursor lands there |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | nerdtree (on trial), netrw | a directory is a text buffer: edit lines = rename/delete/create files |
| [nvim-surround](https://github.com/kylechui/nvim-surround) | vim-surround (legacy vim had it) | add/change/delete surrounding quotes, brackets, tags |
| [persistence.nvim](https://github.com/folke/persistence.nvim) | vim-obsession | auto-saves your session per directory; restore buffers/splits as you left them |
| [mini.pairs](https://github.com/nvim-mini/mini.pairs) | — | type `(` get `()`, auto-closes quotes/brackets |
| [trouble.nvim](https://github.com/folke/trouble.nvim) | chasing `]d` blind | all diagnostics in one navigable bottom panel |
| [render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim) | — | renders markdown (and avante's AI output) in-buffer: headings, code blocks, tables, checkboxes |
| [dropbar.nvim](https://github.com/Bekaboo/dropbar.nvim) | — | VS Code-style breadcrumb bar (file › class › method) across the window top |
| [snacks.nvim](https://github.com/folke/snacks.nvim) | indent-blankline, nvim-notify, dashboard/zen plugins | folke mega-suite; enabled: dashboard, indent guides, notifier, zen, scratch, bigfile/quickfile |
| [harpoon2](https://github.com/ThePrimeagen/harpoon/tree/harpoon2) | — | pin a few hot files, jump between them in 1–2 keys |
| [avante.nvim](https://github.com/yetone/avante.nvim) | (the AI layer) | Cursor-style AI sidebar + inline diffs; key-free via your logged-in `claude` CLI over ACP |
| [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) | — | icons, dependency of lualine/trouble/oil/render-markdown |

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
| `Ctrl-j` / `Ctrl-k` | next / previous item — `j`/`k` alone type into the filter |
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

## Find & replace ([grug-far.nvim](https://github.com/MagicDuck/grug-far.nvim))

The other half of `<leader>R`: fzf-lua *finds*, this one *changes*. Results land in an ordinary editable buffer — review every hit, then apply in one go.

| Key | Does |
|---|---|
| `<leader>S` | open it (normal mode) |
| `<leader>S` | same, pre-filled with the visual selection (visual mode) |
| `:GrugFarWithin` | replace only *inside* the selected range |

It opens in insert mode with the cursor in the first of four inputs — **Search**, **Replace**, **Files Filter**, **Flags**. `Tab`/`Shift-Tab` move between them. Results appear below as you type.

Actions are on `<localleader>`, which is unset here and so falls back to `\`:

| Key | Does |
|---|---|
| `\r` | replace all — writes the change to disk |
| `\s` | sync: push your hand-edits in this buffer back to the files |
| `\c` | close |
| `Enter` | jump to the match under the cursor |
| `Up` / `Down` | open previous / next match (shadows the vimrc_basic resize maps here) |
| `\q` | send results to quickfix |
| `g?` | show every key |

`\r` does a blind replace of the search term; `\s` is for when you edited the result lines by hand and want *those* exact lines written back.

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
LSP progress (indexing etc.) shows in the status line as `45%(2)` — average percent and number of running jobs — via native `vim.ui.progress_status()` in lualine's `lualine_x`. Empty when idle. No keys.

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

## Pinned files ([harpoon2](https://github.com/ThePrimeagen/harpoon/tree/harpoon2))

Pin the handful of files you're actively bouncing between, then jump to any instantly — faster than the
fuzzy finder when you already know the 3–4 files in play.

| Key | Does |
|---|---|
| `<leader>H` | pin the current file |
| `<leader>m` | open the harpoon menu (reorder / remove) |
| `<leader>1`–`<leader>4` | jump to pinned file 1–4 |

## Snacks ([snacks.nvim](https://github.com/folke/snacks.nvim))

folke's utility suite; enabled modules: a startup **dashboard** (on bare `nvim`), **indent guides**, a nicer
**notifier** (replaces nvim-notify), **zen** mode, **scratch** buffers, plus `bigfile`/`quickfile` perf.
Turn modules on/off in `snacks.lua`.

| Key | Does |
|---|---|
| `<leader>z` | zen mode (distraction-free) |
| `<leader>.` | scratch buffer |
| `<leader>n` | notification history |

## Breadcrumb bar ([dropbar.nvim](https://github.com/Bekaboo/dropbar.nvim))

A bar across the top of each window showing your location — `file › class › method` — built from LSP /
treesitter symbols. Mostly passive; one key to navigate it.

| Key | Does |
|---|---|
| `<leader>;` | interactive pick — fuzzy-jump to any symbol in the breadcrumb |

## Markdown rendering ([render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim))

Renders markdown in the buffer instead of showing raw `#`/`*`/backticks — styled headings, boxed code
blocks, bullets, tables, `[ ]` checkboxes. Active in markdown files and in avante's AI responses.
No keymaps; `:RenderMarkdown toggle` flips between rendered and raw (raw when you need to edit precisely).

## Sticky scope ([nvim-treesitter-context](https://github.com/nvim-treesitter/nvim-treesitter-context))

A small always-on header at the top of the window showing the enclosing `class`/`def` (etc.) you're
inside as you scroll — so you never lose track of where you are in a long Python block. No keymaps;
`:TSContextToggle` turns it off/on.

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

## Diffs ([codediff.nvim](https://github.com/esmuellert/codediff.nvim))

Multi-file diffs in their own tab: side-by-side or inline, a file-tree explorer, per-commit history, and 3-way merge. Character-level highlighting, so `self.foo` → `self._foo` marks two characters rather than two whole lines.

| Key | Does |
|---|---|
| `<leader>C` | diff the working tree (opens a new tab) |
| `<leader>ch` | file history for the current file |
| `:CodeDiff main...` | merge-base diff, i.e. PR semantics |

Inside the diff tab (all buffer-local — your normal keys return when you close it):

| Key | Does |
|---|---|
| `q` | close the tab |
| `]c` / `[c` | next / previous change |
| `]f` / `[f` | next / previous file |
| `<leader>e` / `<leader>E` | focus / toggle the explorer panel |
| `t` | toggle side-by-side vs inline |
| `gc` | compact mode — fold unchanged regions |
| `-` | stage/unstage the current file |
| `<leader>hS` / `<leader>hu` / `<leader>hr` | stage / unstage / discard the hunk under the cursor |
| `do` / `dp` | get / put the change, as in vimdiff |
| `ih` | hunk text object (`vih`, `yih`) |
| `g?` | show every key in a float |

(`<leader>hS` not `<leader>hs`, and `<leader>E` not `<leader>b` — its defaults collided with the vimrc_basic split mapping and fzf-lua. `]c`/`[c` and `-` deliberately shadow gitsigns and oil while the diff tab is focused.)

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

## Debugging ([nvim-dap](https://github.com/mfussenegger/nvim-dap) + [nvim-dap-python](https://github.com/mfussenegger/nvim-dap-python) + [nvim-dap-view](https://github.com/igorlfs/nvim-dap-view))

Real breakpoint debugging for Python: stop on a line, step through, inspect live variables in a panel. Replaces injecting `ipdb.set_trace()` into the buffer. `debugpy` is fetched on demand by `uv` — nothing to install.

Function keys because `<leader>d` is trouble and `<leader>b` is fzf-lua.

| Key | Does |
|---|---|
| `<leader>B` | toggle a breakpoint on this line — red `●` in the margin |
| `F5` | start debugging, or continue to the next breakpoint |
| `F10` | step over (run this line, stay in this function) |
| `F11` | step into (descend into the call) |
| `F12` | step out (finish this function, return to the caller) |
| `<leader>V` | toggle the debug panel by hand |

`F5` first asks which configuration to run: `file` (this file), `file:args` (prompts for argv), `attach` (connect to an already-running process), `file:doctest`. The panel opens on session start and closes on exit. Inside it, the `'winbar'` letters switch section (`B` breakpoints, `S` scopes, …) and `g?` lists every key.

Margin markers: `●` breakpoint, `◆` conditional, `◇` log point, `✗` rejected, `▶` where execution is stopped (that line also gets a background). nvim-dap's own defaults are grey letters on the sign column's grey — recoloured in `dap.lua` to the `Diagnostic*` groups so they stay visible if the colourscheme changes.

## Undo history (native `nvim.undotree`)

Vim keeps every past state of a buffer, including branches you "overwrote" by undoing then typing. This shows the whole tree and lets you jump to any state. Bundled with nvim 0.12, `packadd`'d in `init.lua` — not a plugin. Undo history persists across restarts (`undofile`, also set in `init.lua`).

| Key | Does |
|---|---|
| `<leader>u` | toggle the tree panel (30-col split on the left) |
| `j`/`k` | move the cursor — the buffer jumps to that state as you move, no `Enter` |
| `:q` | close (the panel binds no keys of its own, so `q` alone does nothing) |

## Auto-pairs ([mini.pairs](https://github.com/nvim-mini/mini.pairs))

Typing `(`, `[`, `{`, `"`, `'` inserts the closing half; `Backspace` between a pair removes both. No keys to learn.

## Status line ([lualine](https://github.com/nvim-lualine/lualine.nvim))

Pure display: mode/file/position along the bottom, plus native LSP progress in `lualine_x` (replaced fidget.nvim). No keys of its own. There is no buffer bar along the top — bufferline was removed as 19-month-stale decoration; buffers are navigated with the `vimrc_basic` mappings (`Ctrl-N` next, `Ctrl-P` previous, `<leader>D` close current), `<leader>b` to pick one, or harpoon for the hot set.

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
