return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    local lint = require("lint")
    local ruff_config = require("config.ruff")
    lint.linters_by_ft = {
      python = { "ruff", "mypy" },
      lua = { "luacheck" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
    }

    require("lint").linters.mypy.args = {
      "--show-column-numbers",
      "--show-error-end",
      "--hide-error-context",
      "--no-color-output",
      "--no-error-summary",
      "--no-pretty",
      "--check-untyped-defs",
    }

    local ruff = require("lint").linters.ruff
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        local args = {
          "check",
          "--force-exclude",
          "--quiet",
          "--stdin-filename",
          bufname,
          "--no-fix",
          "--output-format",
          "json",
        }
        if not ruff_config.has_ruff_config(bufname) then
          table.insert(args, "--select")
          table.insert(args, table.concat(ruff_config.select, ","))
        end
        table.insert(args, "-")
        ruff.args = args
        lint.try_lint()
      end,
    })
  end,
}
