local M = {}

local defaults_dir = vim.fn.stdpath("config") .. "/defaults"

M.configs = { "pyproject.toml", "ruff.toml", ".ruff.toml" }
M.defaults = defaults_dir .. "/ruff.toml"

function M.has_config(filepath)
  local dir = vim.fn.fnamemodify(filepath, ":h")
  while dir and dir ~= "/" do
    for _, name in ipairs(M.configs) do
      if vim.fn.filereadable(dir .. "/" .. name) == 1 then
        return true
      end
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
