return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix", "ruff_format" },
      lua = { "stylua" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },
  },
  config = function(_, opts)
    require("conform").setup(opts)
    require("conform").formatters.clang_format = {
      inherit = false,
      command = "clang-format",
      args = { "--style=file", "--assume-filename", "$FILENAME" },
      stdin = true,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        pcall(require("conform").format, { async = false })
      end,
    })
  end,
}
