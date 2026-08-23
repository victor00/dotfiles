vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc", "http" },
  callback = function()
    vim.wo.conceallevel = 0
    vim.wo.spell = false
  end,
})

vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    vim.cmd("checktime")
  end,
})
