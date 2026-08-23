return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      if vim.g.dotfiles_skip_mason then
        opts.ensure_installed = {}
        return
      end
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "actionlint",
        "basedpyright",
        "bash-language-server",
        "buf",
        "debugpy",
        "delve",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "gofumpt",
        "goimports",
        "golangci-lint",
        "graphql-language-service-cli",
        "hadolint",
        "helm-ls",
        "json-lsp",
        "lemminx",
        "marksman",
        "protols",
        "ruff",
        "shellcheck",
        "shfmt",
        "sqlfluff",
        "stylua",
        "taplo",
        "terraform-ls",
        "yamllint",
        "yaml-language-server",
      })
    end,
  },
  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby" },
  },
  {
    "slim-template/vim-slim",
    ft = { "slim" },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    -- The next commit adds Vim queries that its pinned parser cannot parse.
    -- Keep this hard pin until upstream ships a matched query/parser revision.
    commit = "f795520371e6563dac17a0d556f41d70ca86a789",
    opts = function(_, opts)
      if vim.g.dotfiles_skip_treesitter then
        opts.ensure_installed = {}
        return
      end
      opts.ensure_installed = vim.list_extend(opts.ensure_installed or {}, {
        "bash",
        "dockerfile",
        "embedded_template",
        "git_config",
        "git_rebase",
        "graphql",
        "helm",
        "hcl",
        "html",
        "http",
        "java",
        "json",
        "python",
        "ruby",
        "sql",
        "terraform",
        "toml",
        "xml",
        "yaml",
      })
    end,
  },
  {
    "nvim-neotest/neotest",
    enabled = function()
      return vim.env.NVIM_DISABLE_TESTS ~= "1"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    enabled = function()
      return vim.g.dotfiles_dap_enabled
    end,
  },
}
