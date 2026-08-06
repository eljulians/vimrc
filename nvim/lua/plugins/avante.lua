return {
  "yetone/avante.nvim",
  -- `make` downloads a prebuilt Rust binary via curl+tar (no compile). To build
  -- from source instead: `make BUILD_FROM_SOURCE=true` (needs cargo).
  build = "make",
  event = "VeryLazy",
  version = false, -- avante REQUIRES this; never set a tag or "*" (breaks the build)
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = function()
    -- Portable across machines: ONE tracked config, auto-pick the agent CLI that
    -- exists here. Work laptop has `claude`; personal has `codex`. Both legs are
    -- defined below; only the selected `provider` is used. Override any time with
    -- :AvanteSwitchProvider. ACP ONLY -- NEVER a direct-API provider with
    -- auth_type="max" (User-Agent-spoofing ban-evasion). See SPACESHIP.md.
    local provider = "claude-code"
    if vim.fn.executable("claude") == 0 and vim.fn.executable("codex") == 1 then
      provider = "codex"
    end

    return {
      provider = provider,
      acp_providers = {
        -- Claude via the official @agentclientprotocol/claude-agent-acp adapter
        -- (npm i -g). Rides the subscription through ~/.claude (no ANTHROPIC_API_KEY
        -- on purpose). NOTE: this is the Agent-SDK path = the Feb-2026 ToS soft-spot.
        -- We wanted the acp-claude-code real-CLI bridge instead, but it's broken vs the
        -- current @anthropic-ai/claude-code package (ERR_MODULE_NOT_FOUND). Revisit if
        -- acp-claude-code ships a fix. See SPACESHIP.md.
        ["claude-code"] = {
          command = "claude-agent-acp",
          args = {},
          env = {
            NODE_NO_WARNINGS = "1",
            CLAUDE_CODE_EXECUTABLE = vim.fn.exepath("claude"),
          },
        },
        -- Codex: rides the ChatGPT subscription via auth_method="chat-gpt" (NOT an
        -- API key). Needs `npm i -g @agentclientprotocol/codex-acp` on that machine.
        ["codex"] = {
          command = "codex-acp",
          args = {},
          auth_method = "chat-gpt",
          env = { NODE_NO_WARNINGS = "1" },
        },
      },
    }
  end,
}
