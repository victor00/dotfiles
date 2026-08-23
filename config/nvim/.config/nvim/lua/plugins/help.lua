local function help(topic)
  return function()
    if vim.fn.executable("dev-help") == 0 then
      vim.notify("dev-help is not linked. Run make link after reviewing conflicts.", vim.log.levels.WARN)
      return
    end
    Snacks.terminal(topic and { "dev-help", topic } or { "dev-help" })
  end
end

return {
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        { "<leader>h", group = "help" },
        { "<leader>i", group = "AI CLI" },
        { "<leader>a", group = "API" },
      },
    },
    keys = {
      { "<leader>hh", help(), desc = "Daily help" },
      { "<leader>hk", help("kubernetes"), desc = "Kubernetes help" },
      { "<leader>hr", help("rails"), desc = "Ruby/Rails help" },
      { "<leader>ha", help("api"), desc = "API help" },
      { "<leader>hz", help("zellij"), desc = "Zellij help" },
    },
  },
}
