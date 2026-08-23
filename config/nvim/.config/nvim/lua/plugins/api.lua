return {
  {
    "mistweaverco/kulala.nvim",
    ft = { "http", "rest" },
    opts = {
      global_keymaps = false,
      global_keymaps_prefix = "<leader>R",
      kulala_keymaps_prefix = "",
    },
    keys = {
      {
        "<leader>ah",
        function()
          require("kulala").run()
        end,
        ft = { "http", "rest" },
        desc = "Run HTTP request",
      },
      {
        "<leader>ab",
        function()
          local executable = vim.fn.executable("bruno") == 1 and "bruno" or (vim.fn.executable("bru") == 1 and "bru" or nil)
          if not executable then
            vim.notify("Bruno is optional and not installed. Run dev-help bruno.", vim.log.levels.WARN)
            return
          end
          vim.system({ executable }, { cwd = vim.fn.getcwd(), detach = true })
        end,
        desc = "Open Bruno here",
      },
      {
        "<leader>ag",
        function()
          Snacks.terminal({ "dev-help", "grpc" })
        end,
        desc = "gRPC help",
      },
      {
        "<leader>aa",
        function()
          Snacks.terminal({ "dev-help", "api" })
        end,
        desc = "API help",
      },
    },
  },
}
