vim.opt.fixendofline = true

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- Get total line count
    local n_lines = vim.api.nvim_buf_line_count(0)
    
    -- Find the last non-empty line
    local last_non_blank = n_lines
    while last_non_blank > 0 do
      local line = vim.api.nvim_buf_get_lines(0, last_non_blank - 1, last_non_blank, false)[1]
      if line and line:match("%S") then
        break
      end
      last_non_blank = last_non_blank - 1
    end

    -- If there are trailing blank lines, delete them
    if last_non_blank < n_lines then
      vim.api.nvim_buf_set_lines(0, last_non_blank, -1, false, {})
    end
  end,
})
