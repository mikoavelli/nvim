return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "ruff", "mypy" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
    }

    local mypy = require("lint").linters.mypy
    mypy.args = {
      "--show-column-numbers",
      "--show-error-end",
      "--hide-error-context",
      "--no-color-output",
      "--no-error-summary",
      "--no-pretty",
      "--check-untyped-defs",
    }
    if vim.env.MYPY_CACHE_DIR and vim.env.MYPY_CACHE_DIR ~= "" then
      table.insert(mypy.args, "--cache-dir=" .. vim.env.MYPY_CACHE_DIR)
    end

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
