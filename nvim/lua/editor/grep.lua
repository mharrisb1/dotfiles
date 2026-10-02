-- Helper function to parse .gitignore into standard grep arguments
local function get_grep_ignore_flags()
  local flags = {}
  local gitignore = vim.fn.findfile(".gitignore", ".;")
  if gitignore == "" then return flags end

  for line in io.lines(gitignore) do
    line = line:gsub("^%s*(.-)%s*$", "%1") -- trim whitespace
    if line ~= "" and not line:match("^#") then
      -- Remove trailing slashes for standard grep format
      local pattern = line:gsub("/$", "")
      
      -- If it's explicitly a directory pattern or has a trailing slash in .gitignore
      if line:match("/$") then
        table.insert(flags, string.format("--exclude-dir=%s", pattern))
      else
        -- Exclude both files and directories matching this pattern name
        table.insert(flags, string.format("--exclude=%s", pattern))
        table.insert(flags, string.format("--exclude-dir=%s", pattern))
      end
    end
  end
  return flags
end

-- Create the custom :Grep command
vim.api.nvim_create_user_command("Grep", function(opts)
  -- 1. Gather gitignore flags
  local ignore_flags = get_grep_ignore_flags()
  
  -- 2. Build the full grep execution array
  -- Includes -I (skip binary files), -n (line numbers), -H (file names), -R (recursive)
  local cmd = { "grep", "-InHR" }
  for _, flag in ipairs(ignore_flags) do
    table.insert(cmd, flag)
  end
  table.insert(cmd, opts.args)
  table.insert(cmd, ".")

  -- 3. Run search asynchronously via vim.fn.jobstart to avoid freezing the UI
  local lines = {}
  vim.fn.jobstart(cmd, {
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then table.insert(lines, line) end
        end
      end
    end,
    on_exit = function()
      -- 4. Load results into the Quickfix list when complete
      if #lines > 0 then
        vim.fn.setqflist({}, "r", { title = "Grep: " .. opts.args, lines = lines })
        vim.cmd("copen") -- Open quickfix window automatically
      else
        vim.notify("No matches found for: " .. opts.args, vim.log.levels.INFO)
      end
    end,
  })
end, { nargs = 1 }) -- Requires exactly one search term argument

