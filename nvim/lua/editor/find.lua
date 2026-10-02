vim.opt.path:append("**")

-- Function to parse .gitignore and add patterns to wildignore
local function apply_gitignore()
  local gitignore = vim.fn.findfile(".gitignore", ".;")
  if gitignore == "" then return end

  for line in io.lines(gitignore) do
    -- Trim whitespace, skip comments and empty lines
    line = line:gsub("^%s*(.-)%s*$", "%1")
    if line ~= "" and not line:match("^#") then
      -- Standardize directory matching for Vim's wildignore syntax
      if line:match("/$") then
        line = "*/" .. line .. "*"
      elseif not line:match("%*") then
        line = "*/" .. line .. "/*,*/" .. line
      end
      
      -- Safely append the pattern to wildignore
      pcall(function() vim.opt.wildignore:append(line) end)
    end
  end
end

-- Run it immediately on startup
apply_gitignore()

