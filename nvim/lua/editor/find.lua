vim.opt.path:append("**")

local ignore = require("editor.ignore")

for _, dir in ipairs(ignore.dirs) do
  vim.opt.wildignore:append("*/" .. dir .. "/*")
end

for _, pattern in ipairs(ignore.files) do
  vim.opt.wildignore:append(pattern)
end
