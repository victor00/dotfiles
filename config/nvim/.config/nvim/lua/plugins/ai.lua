return {
  {
    "folke/sidekick.nvim",
    enabled = function()
      return vim.g.dotfiles_ai_enabled
    end,
    opts = {
      -- Copilot-dependent Next Edit Suggestions are intentionally disabled.
      nes = { enabled = false },
      cli = {
        mux = { enabled = true, backend = "zellij" },
        tools = {
          claude = {},
          codex = {},
          cursor = {},
        },
      },
    },
    keys = {
      { "<leader>aa", false },
      { "<leader>ad", false },
      { "<leader>af", false },
      { "<leader>ap", false },
      { "<leader>as", false },
      { "<leader>at", false },
      { "<leader>av", false },
      {
        "<leader>ii",
        function()
          require("sidekick.cli").select()
        end,
        desc = "Select AI CLI",
      },
      {
        "<leader>ic",
        function()
          require("sidekick.cli").toggle({ name = "claude", focus = true })
        end,
        desc = "Toggle Claude",
      },
      {
        "<leader>ix",
        function()
          require("sidekick.cli").toggle({ name = "codex", focus = true })
        end,
        desc = "Toggle Codex",
      },
      {
        "<C-g>",
        function()
          require("sidekick.cli").focus({ name = "codex" })
        end,
        mode = { "n", "t", "i", "x" },
        desc = "Focus Codex",
      },
      {
        "<leader>iu",
        function()
          require("sidekick.cli").toggle({ name = "cursor", focus = true })
        end,
        desc = "Toggle Cursor agent",
      },
      {
        "<leader>if",
        function()
          require("sidekick.cli").send({ msg = "{file}" })
        end,
        desc = "Send file to AI",
      },
      {
        "<leader>iv",
        function()
          require("sidekick.cli").send({ msg = "{selection}" })
        end,
        mode = "x",
        desc = "Send selection to AI",
      },
      {
        "<leader>ip",
        function()
          require("sidekick.cli").prompt()
        end,
        mode = { "n", "x" },
        desc = "AI prompt actions",
      },
    },
  },
}
