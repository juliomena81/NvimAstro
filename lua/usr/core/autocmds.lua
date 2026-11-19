-- Global automations (API: nvim_create_autocmd)
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })
local transparency = require('usr.core.transparency')

----------------------------------------------------------------------
-- Transparency: reapplied whenever the theme changes
----------------------------------------------------------------------
autocmd('ColorScheme', {
  group = augroup,
  desc = 'Reaplicar fondo transparente',
  callback = function()
    transparency.reset()
  end,
})

----------------------------------------------------------------------
-- Highlight copied text
----------------------------------------------------------------------
autocmd('TextYankPost', {
  group = augroup,
  desc = 'Resaltar texto copiado',
  callback = function()
    vim.hl.on_yank({ higroup = 'IncSearch', timeout = 200 })
  end,
})

----------------------------------------------------------------------
-- Resize splits when the terminal window is resized
----------------------------------------------------------------------
autocmd('VimResized', {
  group = augroup,
  desc = 'Repartir ventanas al redimensionar',
  callback = function()
    vim.cmd('tabdo wincmd =')
  end,
})

----------------------------------------------------------------------
-- Reload files modified outside of Neovim
----------------------------------------------------------------------
autocmd({ 'FocusGained', 'TermClose', 'TermLeave' }, {
  group = augroup,
  desc = 'Comprobar cambios en disco',
  callback = function()
    if vim.o.buftype ~= 'nofile' then
      vim.cmd('checktime')
    end
  end,
})

----------------------------------------------------------------------
-- Return to the last cursor position when reopening a file
----------------------------------------------------------------------
autocmd('BufReadPost', {
  group = augroup,
  desc = 'Restaurar última posición del cursor',
  callback = function(event)
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    local lines = vim.api.nvim_buf_line_count(event.buf)
    if mark[1] > 0 and mark[1] <= lines then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

----------------------------------------------------------------------
-- Create intermediate directories when saving
----------------------------------------------------------------------
autocmd('BufWritePre', {
  group = augroup,
  desc = 'Crear directorios padre al guardar',
  callback = function(event)
    if vim.bo[event.buf].buftype ~= '' then
      return
    end
    local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(event.buf), ':p:h')
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, 'p')
    end
  end,
})

----------------------------------------------------------------------
-- Close auxiliary windows using `q`
----------------------------------------------------------------------
autocmd('FileType', {
  group = augroup,
  desc = 'Cerrar ventanas auxiliares con q',
  pattern = {
    'help',
    'man',
    'qf',
    'lazy',
    'mason',
    'notify',
    'trouble',
    'checkhealth',
    'query',
    'neo-tree',
  },
  callback = function(event)
    local close = vim.bo[event.buf].buftype == 'quickfix' and 'cclose' or 'close'
    vim.keymap.set('n', 'q', '<cmd>' .. close .. '<cr>', {
      buffer = event.buf,
      desc = 'Cerrar ventana',
      silent = true,
    })
  end,
})

----------------------------------------------------------------------
-- Indentation: 4 spaces for Python and shell scripts
----------------------------------------------------------------------
autocmd('FileType', {
  group = augroup,
  desc = 'Indentación de 4 espacios para Python/shell',
  pattern = { 'python', 'sh', 'bash', 'zsh' },
  callback = function()
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

----------------------------------------------------------------------
-- Markdown / text: text wrapping and spell checking
----------------------------------------------------------------------
-- Spanish first, if the dictionary exists; English as a backup.
local function spell_languages()
  local es = vim.fn.stdpath('config') .. '/spell/es.utf-8.spl'
  if vim.fn.filereadable(es) == 1 then
    return { 'es', 'en' }
  end
  return { 'en' }
end

autocmd('FileType', {
  group = augroup,
  desc = 'Ajustes para Markdown y texto',
  pattern = { 'markdown', 'markdown.mdx', 'text', 'gitcommit', 'asciidoc' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
    vim.opt_local.spelllang = spell_languages()
  end,
})
