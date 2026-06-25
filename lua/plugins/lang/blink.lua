return {
  "saghen/blink.cmp",
  version = "1.*",
  event = "CmdlineEnter",
  opts = {
    enabled = function() return false end,
    cmdline = {
      enabled = true,
      keymap = { preset = "cmdline" },
      sources = { "cmdline", "path" },
      completion = {
        menu = { auto_show = function() return true end },
      },
    },
    appearance = { nerd_font_variant = "mono" },
  },
}
