local markdown_injections = [[
(fenced_code_block
  (info_string
    (language) @injection.language)
  (code_fence_content) @injection.content)

((html_block) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined)
  (#set! injection.include-children))

((minus_metadata) @injection.content
  (#set! injection.language "yaml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

((plus_metadata) @injection.content
  (#set! injection.language "toml")
  (#offset! @injection.content 1 0 -1 0)
  (#set! injection.include-children))

([
  (inline)
  (pipe_table_cell)
] @injection.content
  (#set! injection.language "markdown_inline"))
]]

return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "cpp",
      "json",
      "kdl",
      "lua",
      "markdown",
      "markdown_inline",
      "python",
      "query",
      "rust",
      "toml",
      "vim",
      "vimdoc",
    },
    sync_install = false,
    auto_install = true,
    install = {
      prefer_git = true,
    },
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
    vim.treesitter.query.set("markdown", "injections", markdown_injections)
  end,
}
