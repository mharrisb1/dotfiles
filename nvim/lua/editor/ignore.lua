local M = {}

M.dirs = {
  "build",
  "dist",

  ".git",
  ".venv",
  ".pytest",
  ".pytest_cache",

  "__pycache__",
}

M.files = {
  "*.o",
  "*.so",
}

return M
