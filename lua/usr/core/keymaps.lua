-- Global shortcuts
-- <leader> = Space
local map = vim.keymap.set

local function nmap(lhs, rhs, desc, opts)
  map('n', lhs, rhs, vim.tbl_extend('force', { desc = desc, silent = true }, opts or {}))
end

----------------------------------------------------------------------
-- Save / exit / insert
----------------------------------------------------------------------
map({ 'n', 'i', 'v', 'x' }, '<C-s>', '<cmd>write<cr>', { desc = 'Guardar archivo', silent = true })
map('i', 'jj', '<Esc>', { desc = 'Salir de insertar' })
nmap('<leader>qq', '<cmd>quit<cr>', 'Cerrar ventana')
nmap('<leader>qQ', '<cmd>qa!<cr>', 'Salir de Neovim')

----------------------------------------------------------------------
-- Windows and splits
----------------------------------------------------------------------
nmap('<C-h>', '<C-w>h', 'Ventana izquierda')
nmap('<C-j>', '<C-w>j', 'Ventana inferior')
nmap('<C-k>', '<C-w>k', 'Ventana superior')
nmap('<C-l>', '<C-w>l', 'Ventana derecha')
nmap('<C-Up>', '<cmd>resize +2<cr>', 'Aumentar alto')
nmap('<C-Down>', '<cmd>resize -2<cr>', 'Reducir alto')
nmap('<C-Left>', '<cmd>vertical resize -2<cr>', 'Reducir ancho')
nmap('<C-Right>', '<cmd>vertical resize +2<cr>', 'Aumentar ancho')
nmap('<leader>ws', '<cmd>split<cr>', 'Split horizontal')
nmap('<leader>wv', '<cmd>vsplit<cr>', 'Split vertical')
nmap('<leader>wd', '<cmd>close<cr>', 'Cerrar ventana')
nmap('<leader>wo', '<cmd>only<cr>', 'Dejar solo esta ventana')

----------------------------------------------------------------------
-- Buffers
----------------------------------------------------------------------
nmap('<S-l>', '<cmd>bnext<cr>', 'Buffer siguiente')
nmap('<S-h>', '<cmd>bprevious<cr>', 'Buffer anterior')
nmap('<leader>bl', '<cmd>b#<cr>', 'Último buffer')
nmap('<leader>bd', function()
  local ok, snacks = pcall(require, 'snacks')
  if ok and snacks.bufdelete then
    snacks.bufdelete()
  else
    vim.cmd('bdelete')
  end
end, 'Cerrar buffer')
nmap('<leader>bo', function()
  local current = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if buf ~= current and vim.bo[buf].buftype == '' and vim.api.nvim_buf_is_loaded(buf) then
      vim.cmd('bdelete! ' .. buf)
    end
  end
end, 'Cerrar los demás buffers')

----------------------------------------------------------------------
-- Move línes / indent
----------------------------------------------------------------------
nmap('<A-j>', '<cmd>m .+1<cr>==', 'Mover línea abajo')
nmap('<A-k>', '<cmd>m .-2<cr>==', 'Mover línea arriba')
map('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Mover selección abajo', silent = true })
map('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Mover selección arriba', silent = true })
map('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Mover selección abajo', silent = true })
map('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Mover selección arriba', silent = true })
map('v', '<', '<gv', { desc = 'Desindentar', silent = true })
map('v', '>', '>gv', { desc = 'Indentar', silent = true })
map('x', '<leader>p', '"_dP', { desc = 'Pegar sin perder el registro', silent = true })

----------------------------------------------------------------------
-- Search
----------------------------------------------------------------------
nmap('<Esc>', '<cmd>nohlsearch<cr>', 'Limpiar resaltado')
nmap('<leader>nh', '<cmd>nohlsearch<cr>', 'Limpiar resaltado')
nmap('n', 'nzzzv', 'Siguiente coincidencia (centrada)')
nmap('N', 'Nzzzv', 'Coincidencia anterior (centrada)')

----------------------------------------------------------------------
-- Floating terminal (Ctrl+t)
----------------------------------------------------------------------
local function toggle_terminal()
  require('toggleterm').toggle()
end

map(
  { 'n', 'v', 'x', 't' },
  '<C-t>',
  toggle_terminal,
  { desc = 'Terminal flotante (Ctrl+t)', silent = true }
)

----------------------------------------------------------------------
-- Toggle options (<leader>u)
----------------------------------------------------------------------
local function toggle_option(name)
  return function()
    vim.opt_local[name] = not vim.opt_local[name]:get()
  end
end

nmap('<leader>uw', toggle_option('wrap'), 'Alternar wrap')
nmap('<leader>us', toggle_option('spell'), 'Alternar corrector')
nmap('<leader>un', toggle_option('number'), 'Alternar números')
nmap('<leader>ur', toggle_option('relativenumber'), 'Alternar relativos')
nmap('<leader>uc', toggle_option('cursorline'), 'Alternar línea del cursor')
nmap('<leader>uC', function()
  local cc = vim.opt_local.colorcolumn:get()
  vim.opt_local.colorcolumn = #cc > 0 and {} or { 100 }
end, 'Alternar guía de columna 100')
nmap('<leader>ut', function()
  require('usr.core.transparency').toggle()
end, 'Alternar fondo transparente')
nmap('<leader>ud', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, 'Alternar diagnósticos')
nmap('<leader>uf', function()
  vim.g.disable_autoformat = not vim.g.disable_autoformat
  vim.notify('Formato al guardar: ' .. (vim.g.disable_autoformat and 'desactivado' or 'activado'))
end, 'Alternar formato al guardar')
nmap('<leader>uT', function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.treesitter.highlighter.active[buf] then
    vim.treesitter.stop(buf)
    vim.notify('Treesitter: desactivado en este buffer')
  else
    local ok = pcall(vim.treesitter.start, buf)
    vim.notify('Treesitter: ' .. (ok and 'activado' or 'parser no disponible'))
  end
end, 'Alternar Treesitter')
