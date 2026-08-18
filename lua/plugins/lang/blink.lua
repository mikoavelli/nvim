return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "CmdlineEnter",
  opts = {
    enabled = function()
      return false
    end,
    cmdline = {
      enabled = true,
      keymap = {
        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<Tab>"] = {
          function(cmp)
            if cmp.get_selected_item() then
              cmp.accept()
              return true
            end
          end,
          "fallback",
        },
        ["<CR>"] = {
          function(cmp)
            if cmp.get_selected_item() then
              cmp.accept()
              return true
            end
          end,
          "fallback",
        },
        ["<Esc>"] = {
          "hide",
          function()
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n")
          end,
        },
        ["<C-n>"] = {
          function()
            return true
          end,
        },
        ["<C-p>"] = {
          function()
            return true
          end,
        },
      },
      sources = function()
        local t = vim.fn.getcmdtype()
        if t == "/" or t == "?" then
          return { "buffer" }
        end
        if t == ":" or t == "@" then
          return { "cmdline", "path" }
        end
        return {}
      end,
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = {
          auto_show = true,
        },
      },
    },
    appearance = { nerd_font_variant = "mono" },
  },
}
