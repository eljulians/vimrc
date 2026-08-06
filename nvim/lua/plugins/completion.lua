return {
  "saghen/blink.cmp",
  version = "*",              -- pulls a prebuilt binary, no Rust toolchain needed
  event = "InsertEnter",
  opts = {
    keymap = { preset = "super-tab" },   -- Tab to accept/cycle — like your old supertab
    sources = { default = { "lsp", "path", "buffer" } },
  },
}
