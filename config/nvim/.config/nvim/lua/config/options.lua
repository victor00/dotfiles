vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true
vim.opt.confirm = true

-- Heavy integrations can be disabled before startup from a project .lazy.lua.
vim.g.dotfiles_ai_enabled = vim.env.NVIM_DISABLE_AI ~= "1"
vim.g.dotfiles_dap_enabled = vim.env.NVIM_DISABLE_DAP ~= "1"
vim.g.dotfiles_skip_mason = vim.env.NVIM_SKIP_MASON == "1"
vim.g.dotfiles_skip_treesitter = vim.env.NVIM_SKIP_TREESITTER == "1"
