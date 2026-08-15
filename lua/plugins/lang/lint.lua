return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "ruff" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
    }

    local ruff_linter = require("lint").linters.ruff
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        ruff_linter.args = {
          "check",
          "--force-exclude",
          "--quiet",
          "--stdin-filename",
          bufname,
          "--no-fix",
          "--output-format",
          "json",
          "-",
        }
        lint.try_lint()
      end,
    })
  end,
}
