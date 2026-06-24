local opt = vim.opt

opt.clipboard = "unnamedplus"                        -- Sync with system clipboard
opt.confirm = true                                    -- Confirm to save changes before exiting modified buffer
opt.cursorline = true                                 -- Highlight the current line
opt.expandtab = true                                  -- Use spaces instead of tabs
opt.ignorecase = true                                 -- Ignore case in search
opt.inccommand = "nosplit"                            -- Preview substitutions live
opt.list = true                                       -- Show invisible characters (tabs, trailing spaces)
opt.mouse = "a"                                       -- Enable mouse in all modes
opt.number = true                                     -- Print line numbers
opt.relativenumber = true                             -- Relative line numbers
opt.scrolloff = 8                                     -- Lines of context around cursor
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true                                 -- Round indent to multiple of shiftwidth
opt.shiftwidth = 4                                    -- Size of one indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false                                  -- Don't show -- INSERT -- (handled by statusline)
opt.sidescrolloff = 8                                 -- Columns of context horizontally
opt.signcolumn = "yes"                                -- Always show signcolumn (diagnostics/git signs)
opt.smartcase = true                                  -- Case-sensitive search when uppercase used
opt.smartindent = true                                -- Insert indents automatically
opt.smoothscroll = true                               -- Smooth scrolling
opt.splitbelow = true                                 -- New horizontal splits below
opt.splitright = true                                 -- New vertical splits to the right
opt.tabstop = 4                                       -- Number of spaces a tab counts for
opt.termguicolors = true                              -- True color support
opt.timeoutlen = 300                                  -- Timeout for mapped key sequences (ms)
opt.undofile = true                                   -- Persistent undo across sessions
opt.updatetime = 200                                  -- Trigger CursorHold after inactivity (ms)
opt.winminwidth = 5                                   -- Minimum window width
opt.wrap = true                                       -- Wrap lines at window edge

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldtext = ""
opt.formatoptions = "jcroqlnt"                        -- Auto-wrap, comment continuation, etc.
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"                          -- Use ripgrep for :grep
opt.completeopt = "menu,menuone,noselect"             -- Completion popup options
opt.pumheight = 10                                    -- Max items in completion popup
opt.pumblend = 10                                     -- Completion popup transparency

local icons = { Error = " ", Warn = " ", Hint = " ", Info = " " }

vim.diagnostic.config({
  underline = true,
  update_in_insert = false,
  virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = icons.Error,
      [vim.diagnostic.severity.WARN] = icons.Warn,
      [vim.diagnostic.severity.HINT] = icons.Hint,
      [vim.diagnostic.severity.INFO] = icons.Info,
    },
  },
})

vim.api.nvim_create_augroup("Indents", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "Indents",
  pattern = "lua",
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = "Indents",
  pattern = { "sh", "bash", "zsh" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
  end,
})
