-- Neovim configuration -- fresh, incremental build.
--
-- Isolated from the legacy vim *extended* config: we reuse only the portable
-- basic vimscript settings (repo/vimrc_basic) and layer neovim-native features
-- on top via lazy.nvim.
--
-- Installed declaratively via scripts/install_nvim.sh, which symlinks
-- ~/.config/nvim -> this directory. Keep everything tracked in this repo;
-- don't hand-place anything under ~/.config.

-- 1. Portable basics --------------------------------------------------------
-- Source the single source-of-truth basic settings shared with legacy vim.
-- This also sets <leader> (Space), which MUST happen before lazy.nvim loads so
-- plugin keymaps bind correctly.
-- stdpath('config') is ~/.config/nvim (a symlink); resolve() follows it to
-- repo/nvim, and :h drops to the repo root.
local repo_root = vim.fn.fnamemodify(vim.fn.resolve(vim.fn.stdpath('config')), ':h')
vim.cmd('source ' .. repo_root .. '/vimrc_basic')

-- 2. Plugin manager (lazy.nvim) --------------------------------------------
-- Self-bootstrap: clone lazy.nvim on first launch. Exact plugin versions are
-- pinned by the tracked lazy-lock.json (written next to this file).
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
    }, true, {})
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- 3. Plugin specs -----------------------------------------------------------
-- Specs live in lua/plugins/, one file per plugin, added incrementally as we
-- migrate features over. Inventory + keybindings: README.md.
require('lazy').setup({
  { import = 'plugins' },
})

-- 4. Native 0.12 packages ---------------------------------------------------
-- Shipped with the nvim runtime, opt-in via packadd. Not plugins, so they
-- don't live in lua/plugins/.

-- Keep undo history on disk so the tree survives restarts. Lived in
-- undotree.lua's init() until mbbill/undotree was dropped (item 9); it is not
-- undotree-specific, so it belongs here now.
vim.o.undofile = true

-- Undo-tree browser, replaces mbbill/undotree. packadd is cheap: it only
-- sources the 8-line file that defines :Undotree, and the implementation is
-- require'd on first use. :Undotree toggles a 30-col split, and moving the
-- cursor in it changes the undo state live -- no <CR> to preview.
vim.cmd.packadd('nvim.undotree')
vim.keymap.set('n', '<leader>u', '<cmd>Undotree<cr>', { desc = 'Undo tree' })
