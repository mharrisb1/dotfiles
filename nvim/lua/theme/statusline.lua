local err = vim.api.nvim_get_hl(0, { name = "DiagnosticError", link = false })
local dir = vim.api.nvim_get_hl(0, { name = "Directory", link = false })
local pms = vim.api.nvim_get_hl(0, { name = "PmenuSel", link = false })

vim.api.nvim_set_hl(0, "StlModeNormal", { fg = "#d1d1d1", bg = "#292929", bold = true })
vim.api.nvim_set_hl(0, "StlModeInsert", { fg = "#292929", bg = "#3691f9", bold = true })
vim.api.nvim_set_hl(0, "StlModeVisual", { fg = "#292929", bg = "#f8ab17", bold = true })
vim.api.nvim_set_hl(0, "StlModeCommand", { fg = "#292929", bg = "#c07bf3", bold = true })
vim.api.nvim_set_hl(0, "StlModeReplace", { fg = "#292929", bg = "#ec7388", bold = true })
vim.api.nvim_set_hl(0, "StlModeTerminal", { fg = "#292929", bg = "#a8cc7c", bold = true })
vim.api.nvim_set_hl(0, "StlGit", { fg = dir.fg, bg = pms.bg })

vim.api.nvim_set_hl(0, "TabLineFill", { bg = "#1c1c1c" })
vim.api.nvim_set_hl(0, "Tabline", { fg = "#7c7c7c", bg = "#1c1c1c" })
vim.api.nvim_set_hl(0, "TablineSel", { fg = "#d1d1d1", bg = "#292929", bold = true })
vim.api.nvim_set_hl(0, "TablineModified", { fg = "#3691f9", bg = "#1c1c1c" })
vim.api.nvim_set_hl(0, "TablineSelModified", { fg = "#3691f9", bg = "#292929", bold = true })

local modes = {
  n = "NORMAL",
  i = "INSERT",
  v = "VISUAL",
  V = "V-LINE",
  ["\22"] = "V-BLOCK",
  c = "COMMAND",
  t = "TERMINAL",
  R = "REPLACE",
  s = "SELECT",
  S = "S-LINE",
  ["\19"] = "S-BLOCK",
}

function _G._statusline()
  local mode_key = vim.fn.mode()
  local mode = modes[mode_key] or mode_key:upper()

  local mode_hl = "StlModeNormal"
  if mode_key == "i" then
    mode_hl = "StlModeInsert"
  elseif mode_key == "v" or mode_key == "V" or mode_key == "\22" then
    mode_hl = "StlModeVisual"
  elseif mode_key == "c" then
    mode_hl = "StlModeCommand"
  elseif mode_key == "R" then
    mode_hl = "StlModeReplace"
  elseif mode_key == "t" then
    mode_hl = "StlModeTerminal"
  end

  local branch = vim.b.git_branch and "%#StlGit# " .. vim.b.git_branch .. " %*" or ""
  local path = vim.b.rel_path or "%f"

  local diag = ""
  local diagnostics = vim.diagnostic.get(0)
  local counts = { 0, 0, 0, 0 }
  for _, d in ipairs(diagnostics) do
    counts[d.severity] = counts[d.severity] + 1
  end
  
  local labels = { " ", " ", " ", " " }
  local hls = { "DiagnosticError", "DiagnosticWarn", "DiagnosticInfo", "DiagnosticHint" }
  for i = 1, 4 do
    diag = diag .. "%#" .. hls[i] .. "#" .. labels[i] .. counts[i] .. "%* "
  end

  return "%#" .. mode_hl .. "# " .. mode .. " %*" .. branch .. " " .. path .. "%=" .. diag .. vim.bo.filetype .. " %l:%c"
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
    if root ~= "" then
      vim.b.git_branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("%s+$", "")
      vim.b.rel_path = vim.fn.expand("%:p"):sub(#root + 2)
    else
      vim.b.git_branch = nil
      vim.b.rel_path = vim.fn.expand("%:p:~")
    end 
  end,
})

vim.api.nvim_create_autocmd("DiagnosticChanged", {
  callback = function()
    vim.cmd("redrawstatus!")
  end,
})

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

vim.o.statusline = "%!v:lua._statusline()"
vim.o.tabline = "%!v:lua._tabline()"
vim.showtabline = 2

