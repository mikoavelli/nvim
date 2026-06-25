local M = {
  lineLength = 100,
  select = { "E", "W", "F", "I", "UP", "S", "B", "N" },
}

function M.has_ruff_config(filepath)
  local dir = vim.fn.fnamemodify(filepath, ":h")
  while dir and dir ~= "/" do
    if vim.fn.filereadable(dir .. "/pyproject.toml") == 1 then
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
