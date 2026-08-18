return {
  "stevearc/conform.nvim",
  opts = {
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
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
  end,
}
