---@diagnostic disable
local xplr = xplr -- The globally exposed configuration to be overridden.
---@diagnostic enable

version = '1.0.0'

-- setting overrides
xplr.config.general.show_hidden = true

-- hacks
local function stat(node)
  return xplr.util.to_yaml(xplr.util.node(node.absolute_path))
end

local function read(path, height)
  local p = io.open(path)

  if p == nil then
    return nil
  end

  local i = 0
  local res = ""
  for line in p:lines() do
    if line:match("[^ -~\n\t]") then
      p:close()
      return
    end

    -- Expand tabs to spaces
    line = line:gsub("\t", "        ")
    res = res .. line .. "\n"
    if i == height then
      break
    end
    i = i + 1
  end
  p:close()

  return res
end

xplr.fn.custom.preview_pane = {}
xplr.fn.custom.preview_pane.render = function(ctx)
  local title = nil
  local body = ""
  local n = ctx.app.focused_node
  if n and n.canonical then
    n = n.canonical
  end

  if n then
    title = { format = n.absolute_path, style = xplr.util.lscolor(n.absolute_path) }
    if n.is_file then
      body = read(n.absolute_path, ctx.layout_size.height) or stat(n)
    else
      body = stat(n)
    end
  end

  -- Pad body to fill the pane dimensions and clear previous content
  local width = ctx.layout_size.width
  local height = ctx.layout_size.height
  local blank_line = string.rep(" ", width)
  local lines = {}
  for line in (body .. "\n"):gmatch("(.-)\n") do
    if #line > width then
      line = line:sub(1, width)
    elseif #line < width then
      line = line .. string.rep(" ", width - #line)
    end
    table.insert(lines, line)
  end
  while #lines < height do
    table.insert(lines, blank_line)
  end
  body = table.concat(lines, "\n")

  return { CustomParagraph = { ui = { title = title }, body = body } }
end

local preview_pane = { Dynamic = "custom.preview_pane.render" }
local split_preview = {
  Horizontal = {
    config = {
      constraints = {
        { Percentage = 60 },
        { Percentage = 40 },
      },
    },
    splits = {
      "Table",
      preview_pane,
    },
  },
}

xplr.config.layouts.builtin.default =
    xplr.util.layout_replace(xplr.config.layouts.builtin.default, "Table", split_preview)


-- plugin management
local home = os.getenv("HOME")
local xpm_path = home .. "/.local/share/xplr/dtomvan/xpm.xplr"
local xpm_url = "https://github.com/dtomvan/xpm.xplr"

package.path = package.path
    .. ";"
    .. xpm_path
    .. "/?.lua;"
    .. xpm_path
    .. "/?/init.lua"

os.execute(
  string.format(
    "[ -e '%s' ] || git clone '%s' '%s'",
    xpm_path,
    xpm_url,
    xpm_path
  )
)

require("xpm").setup({
  plugins = {
    -- Let xpm manage itself
    'dtomvan/xpm.xplr',
    { name = 'sayanarijit/fzf.xplr' },
    { name = 'sayanarijit/tree-view.xplr' },
    { name = 'prncss-xyz/icons.xplr' },
    { name = 'dtomvan/extra-icons.xplr' },
    { name = 'sayanarijit/map.xplr' }
  },
  auto_install = true,
  auto_cleanup = true,
})

require("fzf").setup()
require("tree-view").setup()
require("icons").setup()
require("extra-icons").setup()
