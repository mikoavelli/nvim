return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  branch = "master",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    ensure_installed = {
      "python",
      "c",
      "cpp",
      "rust",
      "lua",
      "bash",
      "vim",
      "vimdoc",
      "query",
      "toml",
      "kdl",
      "json"
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
    local ok, ts = pcall(require, "nvim-treesitter.config")
    if ok then
      ts.setup(opts)
    else
      require("nvim-treesitter.configs").setup(opts)
    end
  end,
}