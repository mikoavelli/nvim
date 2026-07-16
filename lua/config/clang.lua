local M = {}

local defaults_dir = vim.fn.stdpath("config") .. "/defaults"

M.defaults = defaults_dir .. "/clang-format"

function M.has_config(filepath)
  local dir = vim.fn.fnamemodify(filepath, ":h")
  while dir and dir ~= "/" do
    if vim.fn.filereadable(dir .. "/.clang-format") == 1 then
      return true
    end
    local parent = vim.fn.fnamemodify(dir, ":h")
    if parent == dir then
      break
    end
    dir = parent
  end
  return false
end

return M
