return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "ruff_fix" },
      lua = { "stylua" },
      c = { "clang_format" },
      cpp = { "clang_format" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },
  },
  config = function(_, opts)
    local ruff_config = require("config.ruff")
    local clang = require("config.clang")
    require("conform").setup(opts)
    require("conform").formatters.clang_format = {
      inherit = false,
      command = "clang-format",
      args = function(self, ctx)
        if clang.has_config(ctx.filename) then
          return { "--style=file", "--assume-filename", ctx.filename }
        end
        return { "--style=file:" .. clang.defaults, "--assume-filename", ctx.filename }
      end,
      stdin = true,
    }
    require("conform").formatters.ruff_fix = {
      inherit = false,
      command = "ruff",
      args = function(self, ctx)
        local args = {
          "check",
          "--fix",
          "--force-exclude",
          "--exit-zero",
          "--no-cache",
          "--stdin-filename",
          ctx.filename,
        }
        if not ruff_config.has_ruff_config(ctx.filename) then
          vim.list_extend(args, { "--select", table.concat(ruff_config.select, ",") })
        end
        table.insert(args, "-")
        return args
      end,
      stdin = true,
    }
    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        pcall(require("conform").format, { async = false })
      end,
    })
  end,
}
