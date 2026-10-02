vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end

vim.g.colors_name = "fleet"
vim.o.termguicolors = true

-------------------------------------------------------------------------------
-- Fleet Palette
-------------------------------------------------------------------------------
local p = {
  bg            = "#181818", -- Primary dark background
  bg_dark       = "#121212", -- Darker background (float/sidebars)
  bg_light      = "#222222", -- Slightly lighter background (selections, visual)
  bg_highlight  = "#2a2a2a", -- Cursorline, current item highlight
  bg_subtle     = "#333333", -- Subtle UI borders, splitters

  fg            = "#c1c8cd", -- Primary foreground
  fg_dim        = "#81888d", -- Comments, muted UI elements
  fg_dark       = "#51585d", -- Inactive elements, whitespace

  blue          = "#68a0e5", -- Functions, keywords
  cyan          = "#5db3b3", -- Types, classes, interfaces
  green         = "#70b484", -- Strings, green accents
  orange        = "#df8e5d", -- Numbers, constants, parameters
  purple        = "#b388ff", -- Keywords, control flow, operators
  red           = "#e06c75", -- Errors, deleted lines, warnings
  yellow        = "#e5c07b", -- Attributes, fields, warnings
  pink          = "#e070a0", -- Special tags, regex, regex escapes

  diff_add      = "#1c3224",
  diff_change   = "#2c2a1e",
  diff_delete   = "#381f21",
}

-------------------------------------------------------------------------------
-- Highlight Helper Function
-------------------------------------------------------------------------------
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-------------------------------------------------------------------------------
-- Core Vim Editor Highlights
-------------------------------------------------------------------------------
hl("Normal",        { fg = p.fg, bg = p.bg })
hl("NormalFloat",   { fg = p.fg, bg = p.bg_dark })
hl("FloatBorder",   { fg = p.bg_subtle, bg = p.bg_dark })
hl("ColorColumn",   { bg = p.bg_light })
hl("Cursor",        { fg = p.bg, bg = p.fg })
hl("CursorLine",    { bg = p.bg_highlight })
hl("CursorColumn",  { bg = p.bg_highlight })
hl("LineNr",        { fg = p.fg_dark, bg = p.bg })
hl("CursorLineNr",  { fg = p.fg, bg = p.bg, bold = true })
hl("VertSplit",     { fg = p.bg_subtle, bg = p.bg })
hl("WinSeparator",  { fg = p.bg_subtle, bg = p.bg })
hl("Folded",        { fg = p.fg_dim, bg = p.bg_light })
hl("FoldColumn",    { fg = p.fg_dark, bg = p.bg })
hl("SignColumn",    { fg = p.fg, bg = p.bg })
hl("Pmenu",         { fg = p.fg, bg = p.bg_dark })
hl("PmenuSel",      { fg = p.fg, bg = p.bg_subtle, bold = true })
hl("PmenuSbar",     { bg = p.bg_dark })
hl("PmenuThumb",    { bg = p.fg_dark })
hl("StatusLine",    { fg = p.fg, bg = p.bg_dark })
hl("StatusLineNC",  { fg = p.fg_dim, bg = p.bg_dark })
hl("Search",        { fg = p.bg, bg = p.yellow })
hl("IncSearch",     { fg = p.bg, bg = p.orange })
hl("CurSearch",     { fg = p.bg, bg = p.orange })
hl("Visual",        { bg = p.bg_subtle })
hl("VisualNOS",     { bg = p.bg_subtle })
hl("MatchParen",    { fg = p.cyan, bold = true, underline = true })
hl("NonText",       { fg = p.fg_dark })
hl("Whitespace",    { fg = p.fg_dark })
hl("Directory",     { fg = p.blue })
hl("Title",         { fg = p.blue, bold = true })
hl("ErrorMsg",      { fg = p.red })
hl("WarningMsg",    { fg = p.orange })
hl("Question",      { fg = p.green })
hl("MoreMsg",       { fg = p.green })

-------------------------------------------------------------------------------
-- Syntax Highlighting
-------------------------------------------------------------------------------
hl("Comment",       { fg = p.fg_dim, italic = true })
hl("Constant",      { fg = p.orange })
hl("String",        { fg = p.green })
hl("Character",     { fg = p.green })
hl("Number",        { fg = p.orange })
hl("Boolean",       { fg = p.orange, bold = true })
hl("Float",         { fg = p.orange })
hl("Identifier",    { fg = p.fg })
hl("Function",      { fg = p.blue })
hl("Statement",     { fg = p.purple })
hl("Conditional",   { fg = p.purple })
hl("Repeat",        { fg = p.purple })
hl("Label",         { fg = p.purple })
hl("Operator",      { fg = p.fg_dim })
hl("Keyword",       { fg = p.purple })
hl("Exception",     { fg = p.purple })
hl("PreProc",       { fg = p.pink })
hl("Include",       { fg = p.purple })
hl("Define",        { fg = p.purple })
hl("Macro",         { fg = p.pink })
hl("Type",          { fg = p.cyan })
hl("StorageClass",  { fg = p.purple })
hl("Structure",     { fg = p.cyan })
hl("Typedef",       { fg = p.cyan })
hl("Special",       { fg = p.pink })
hl("SpecialChar",   { fg = p.pink })
hl("Tag",           { fg = p.yellow })
hl("Delimiter",     { fg = p.fg_dim })
hl("Underlined",    { underline = true })
hl("Bold",          { bold = true })
hl("Italic",        { italic = true })
hl("Error",         { fg = p.red, bold = true })
hl("Todo",          { fg = p.bg, bg = p.yellow, bold = true })

-------------------------------------------------------------------------------
-- TreeSitter
-------------------------------------------------------------------------------
hl("@comment",              { link = "Comment" })
hl("@variable",             { fg = p.fg })
hl("@variable.builtin",     { fg = p.red, italic = true })
hl("@variable.parameter",   { fg = p.orange })
hl("@variable.member",      { fg = p.yellow })
hl("@constant",             { link = "Constant" })
hl("@constant.builtin",     { fg = p.orange, bold = true })
hl("@string",               { link = "String" })
hl("@string.regex",         { fg = p.pink })
hl("@string.escape",        { fg = p.pink })
hl("@character",            { link = "Character" })
hl("@number",               { link = "Number" })
hl("@boolean",              { link = "Boolean" })
hl("@number.float",         { link = "Float" })
hl("@function",             { link = "Function" })
hl("@function.builtin",     { fg = p.blue, italic = true })
hl("@function.macro",       { fg = p.pink })
hl("@parameter",            { fg = p.orange })
hl("@method",               { fg = p.blue })
hl("@field",                { fg = p.yellow })
hl("@property",             { fg = p.yellow })
hl("@constructor",          { fg = p.cyan })
hl("@conditional",          { link = "Conditional" })
hl("@repeat",               { link = "Repeat" })
hl("@label",                { link = "Label" })
hl("@operator",             { link = "Operator" })
hl("@keyword",              { link = "Keyword" })
hl("@keyword.function",     { fg = p.purple, bold = true })
hl("@keyword.operator",     { fg = p.purple })
hl("@exception",            { link = "Exception" })
hl("@type",                 { link = "Type" })
hl("@type.builtin",         { fg = p.cyan, italic = true })
hl("@type.qualifier",       { fg = p.purple })
hl("@structure",            { link = "Structure" })
hl("@include",              { link = "Include" })
hl("@namespace",            { fg = p.cyan })
hl("@punct.delimiter",      { fg = p.fg_dim })
hl("@punct.bracket",        { fg = p.fg_dim })
hl("@punct.special",        { fg = p.pink })
hl("@tag",                  { fg = p.purple })
hl("@tag.attribute",        { fg = p.yellow })
hl("@tag.delimiter",        { fg = p.fg_dark })

-------------------------------------------------------------------------------
-- LSP & Diagnostics
-------------------------------------------------------------------------------
hl("DiagnosticError",       { fg = p.red })
hl("DiagnosticWarn",        { fg = p.orange })
hl("DiagnosticInfo",        { fg = p.blue })
hl("DiagnosticHint",        { fg = p.cyan })

hl("DiagnosticUnderlineError", { underline = true, sp = p.red })
hl("DiagnosticUnderlineWarn",  { underline = true, sp = p.orange })
hl("DiagnosticUnderlineInfo",  { underline = true, sp = p.blue })
hl("DiagnosticUnderlineHint",  { underline = true, sp = p.cyan })

hl("LspReferenceText",      { bg = p.bg_light })
hl("LspReferenceRead",      { bg = p.bg_light })
hl("LspReferenceWrite",     { bg = p.bg_light })

-------------------------------------------------------------------------------
-- Plugin Support: Telescope
-------------------------------------------------------------------------------
hl("TelescopeNormal",       { fg = p.fg, bg = p.bg_dark })
hl("TelescopeBorder",       { fg = p.bg_subtle, bg = p.bg_dark })
hl("TelescopePromptBorder", { fg = p.bg_subtle, bg = p.bg_dark })
hl("TelescopeResultsBorder",{ fg = p.bg_subtle, bg = p.bg_dark })
hl("TelescopePreviewBorder",{ fg = p.bg_subtle, bg = p.bg_dark })
hl("TelescopeSelection",    { bg = p.bg_subtle })
hl("TelescopeMatching",     { fg = p.blue, bold = true })

-------------------------------------------------------------------------------
-- Plugin Support: NvimTree / Neo-tree
-------------------------------------------------------------------------------
hl("NvimTreeNormal",        { fg = p.fg, bg = p.bg_dark })
hl("NvimTreeNormalNC",      { fg = p.fg, bg = p.bg_dark })
hl("NvimTreeRootFolder",    { fg = p.blue, bold = true })
hl("NvimTreeGitDirty",      { fg = p.yellow })
hl("NvimTreeGitNew",        { fg = p.green })
hl("NvimTreeGitDeleted",    { fg = p.red })

-------------------------------------------------------------------------------
-- Plugin Support: Gitsigns / Git Diff
-------------------------------------------------------------------------------
hl("GitSignsAdd",           { fg = p.green })
hl("GitSignsChange",        { fg = p.yellow })
hl("GitSignsDelete",        { fg = p.red })

hl("DiffAdd",               { bg = p.diff_add })
hl("DiffChange",            { bg = p.diff_change })
hl("DiffDelete",            { bg = p.diff_delete })
hl("DiffText",              { bg = p.bg_subtle, bold = true })

