-- Controllable transparent background (:Transparency, <leader>ut)
local M = {}

-- Groups that should have their background removed
-- (editor, floating windows, and plugin panels)
local groups = {
  'Normal',
  'NormalNC',
  'NormalFloat',
  'FloatBorder',
  'FloatTitle',
  'SignColumn',
  'FoldColumn',
  'EndOfBuffer',
  'WinSeparator',
  'StatusLine',
  'StatusLineNC',
  'Pmenu',
  'NeoTreeNormal',
  'NeoTreeNormalNC',
  'NeoTreeEndOfBuffer',
  'NeoTreeWinSeparator',
  'NeoTreeTitleBar',
  'FzfLuaNormal',
  'FzfLuaBorder',
  'FzfLuaTitle',
  'FzfLuaHeader',
  'SnacksNormal',
  'SnacksNormalNC',
  'SnacksWinBar',
  'SnacksWinBarNC',
  'LazyNormal',
  'MasonNormal',
  'MasonHeader',
  'TroubleNormal',
  'TroubleNormalNC',
  'WhichKeyFloat',
  'WhichKeyNormal',
  'NotifyBackground',
  'NvimTreeNormal',
  'NvimTreeNormalNC',
  'TelescopeNormal',
  'TelescopeBorder',
}

local saved = {}

local function clear_bg(name)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })
  if vim.tbl_isempty(hl) then
    return
  end
  saved[name] = vim.deepcopy(hl)
  hl.bg = nil
  vim.api.nvim_set_hl(0, name, hl)
end

local function restore_bg(name)
  if saved[name] then
    vim.api.nvim_set_hl(0, name, saved[name])
  end
end

--- Applies or reverts transparency based on vim.g.transparent
function M.apply()
  if vim.g.transparent then
    for _, name in ipairs(groups) do
      clear_bg(name)
    end
  else
    for _, name in ipairs(groups) do
      restore_bg(name)
    end
  end
end

--- Clears saved colors and reapplies (use after changing the theme)
function M.reset()
  saved = {}
  M.apply()
end

function M.toggle()
  vim.g.transparent = not vim.g.transparent
  if vim.g.transparent then
    saved = {}
  end
  M.apply()
  vim.notify('Fondo ' .. (vim.g.transparent and 'transparente' or 'sólido'))
end

--- Creates the `:Transparency` command
function M.setup()
  vim.api.nvim_create_user_command('Transparency', function()
    M.toggle()
  end, { desc = 'Alternar fondo transparente' })
end

-- Applies on startup
-- (in case the theme does not trigger a `ColorScheme` event)
vim.api.nvim_create_autocmd('VimEnter', {
  once = true,
  callback = function()
    M.apply()
  end,
})

return M
