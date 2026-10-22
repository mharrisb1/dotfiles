local ignore = require("editor.ignore")

local function build_grepprg()
  local args = { "grep", "-nH", "-r" }

  for _, dir in ipairs(ignore.dirs) do
    table.insert(args, string.format("--exclude-dir=%s", dir))
  end

  for _, pattern in ipairs(ignore.files) do
    table.insert(args, string.format("--exclude=%s", pattern))
  end

  return table.concat(args, " ")
end

vim.opt.grepprg = build_grepprg()
