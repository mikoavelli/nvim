return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff" },
      lua = { "stylua" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        pcall(require("conform").format, { async = false })
      end,
    })
  end,
}
