vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#1c1c1c" })
vim.api.nvim_set_hl(0, "Tabline", { fg = "#7c7c7c", bg = "#1c1c1c" })
vim.api.nvim_set_hl(0, "TablineSel", { fg = "#d1d1d1", bg = "#292929", bold = true })
vim.api.nvim_set_hl(0, "TablineModified", { fg = "#3691f9", bg = "#1c1c1c" })
vim.api.nvim_set_hl(0, "TablineSelModified", { fg = "#3691f9", bg = "#292929", bold = true })

function _G._tabline()
  local result = ""
  local current_buf = vim.api.nvim_get_current_buf()

  local buffers = vim.tbl_filter(function(buf)
    if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].buflisted then
      return false
    end

    local buftype = vim.bo[buf].filetype
    if filetype == "netrw" or filetype == "help" or filetype == "qf" then
      return false
    end
    
    return true
  end, vim.api.nvim_list_bufs())
  
  for _, buf in ipairs(buffers) do
    local name = vim.api.nvim_buf_get_name(buf)
    local filename = name ~= "" and vim.fn.fnamemodify(name, ":t") or "[No Name]"
    local modified = vim.bo[buf].modified

    local hl
    if buf == current_buf then
      hl = modified and "TabLineSelModified" or "TabLineSel"
    else
      hl = modified and "TabLineModified" or "TabLine"
    end

    result = result .. "%#" .. hl .. "#"
    result = result .. " " .. filename
    if modified then
      result = result .. " \u{25CF}"
    end
    result = result .. " "
  end

  result = result .. "%#TablineFill#"
  return result
end

vim.opt.tabline = "%!v:lua._tabline()"
vim.opt.showtabline = 2

