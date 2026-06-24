return {
  "folke/snacks.nvim",
  opts = {
    notifier = {
      enabled = true,
      margin = { top = 1 },
    },
  },
  config = function(_, opts)
    require("snacks").setup(opts)
  end,
}
