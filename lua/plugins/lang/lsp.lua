return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    local lspconfig = require("lspconfig")

    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "basedpyright", "ruff", "lua_ls", "rust_analyzer" },
      handlers = {
        function(server_name)
          local servers = { "basedpyright", "ruff", "lua_ls", "rust_analyzer" }
          if not vim.tbl_contains(servers, server_name) then
            lspconfig[server_name].setup({ capabilities = capabilities })
          end
        end,
        ["basedpyright"] = function()
          lspconfig.basedpyright.setup({
            capabilities = capabilities,
            settings = {
              basedpyright = {
                analysis = {
                  typeCheckingMode = "basic",
                  diagnosticMode = "openFilesOnly",

                  inlayHints = {
                    variableTypes = true,
                    functionReturnTypes = true,
                    callArgumentNames = true,
                  },
                },
              },
            },
          })
        end,

        ["ruff"] = function()
          lspconfig.ruff.setup({
            capabilities = capabilities,
            settings = {
              ruff = {
                lineLength = 100,
                lint = { select = {} },
              },
            },
          })
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = "LuaJIT" },
                diagnostics = { globals = { "vim" } },
                workspace = {
                  library = vim.api.nvim_get_runtime_file("", true),
                  checkThirdParty = false,
                },
              },
            },
          })
        end,
        ["rust_analyzer"] = function()
          lspconfig.rust_analyzer.setup({
            capabilities = capabilities,
            settings = {
              ["rust-analyzer"] = {
                check = { command = "clippy" },
                diagnostics = { disabled = {} },
                cargo = { allFeatures = true },
              },
            },
          })
        end,
      },
    })

    vim.lsp.inlay_hint.enable(true)

    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*.rs",
      callback = function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf(), name = "rust_analyzer" })
      end,
      group = vim.api.nvim_create_augroup("RustFormat", { clear = true }),
    })
  end,
}
