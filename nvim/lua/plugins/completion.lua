return {
  "saghen/blink.cmp",
  version = "*",              -- pulls a prebuilt binary, no Rust toolchain needed
  event = "InsertEnter",
  opts = {
    keymap = { preset = "super-tab" },   -- Tab to accept/cycle — like your old supertab
    sources = { default = { "lsp", "path", "buffer" } },
    -- No completion popup in avante's AI prompt/sidebar buffers (typing English
    -- at it, not code). Keeps blink's default "off in prompt buffers" too.
    enabled = function()
      if vim.bo.filetype:sub(1, 6) == "Avante" then return false end
      return vim.bo.buftype ~= "prompt"
    end,
  },
}
