-- Global options, filetypes and environment.
-- Style: 2 spaces by default; Python/shell to 4 (see autocmds.lua).
local opt = vim.opt

----------------------------------------------------------------------
-- Environment
----------------------------------------------------------------------
-- Own binaries (stylua, prettier, ruff, shfmt ...)
local local_bin = vim.fn.expand('~/.local/bin')
if not vim.env.PATH:find(local_bin, 1, true) then
  vim.env.PATH = local_bin .. ':' .. vim.env.PATH
end

vim.g.loaded_perl_provider = 0
vim.g.have_nerd_font = true

-- Shell / Zsh / ERB
vim.filetype.add({
  extension = {
    zsh = 'sh',
    zshrc = 'sh',
    zprofile = 'sh',
    erb = 'eruby',
    astro = 'astro',
    mdx = 'markdown',
    svg = 'xml',
  },
  filename = {
    ['.zshrc'] = 'sh',
    ['.zprofile'] = 'sh',
  },
})

----------------------------------------------------------------------
-- Interface
----------------------------------------------------------------------
opt.number = true
opt.relativenumber = true
opt.signcolumn = 'yes:2'
opt.cursorline = true
opt.termguicolors = true
opt.winborder = 'rounded' -- float borders (0.11+)
opt.laststatus = 3 -- global status bar
opt.showmode = false
opt.pumheight = 12
opt.pumblend = 0
opt.wildoptions = 'pum'
opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.showbreak = '↳ '
opt.showmatch = true
opt.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣', extends = '›', precedes = '‹' }
opt.fillchars = { eob = ' ', fold = ' ', vert = '│' }
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.whichwrap:append('<>[]hl')
opt.wildmode = 'longest:full,full'

----------------------------------------------------------------------
-- Edition
----------------------------------------------------------------------
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.smartindent = true
opt.autoindent = true
opt.breakindent = true
opt.undofile = true
opt.undolevels = 10000
opt.swapfile = false
opt.backup = false
opt.updatetime = 250
opt.timeoutlen = 300
opt.ttimeoutlen = 10
opt.confirm = true
opt.mouse = 'a'
opt.clipboard = 'unnamedplus'
opt.virtualedit = 'block'
opt.inccommand = 'split'
opt.completeopt = { 'menu', 'menuone', 'noselect' }
opt.formatoptions = 'jcroqlnt'
opt.sessionoptions =
  { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

----------------------------------------------------------------------
-- Search
----------------------------------------------------------------------
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true
opt.grepprg = 'rg --vimgrep --smart-case --hidden --glob=!.git/*'
opt.grepformat = '%f:%l:%c:%m'

----------------------------------------------------------------------
-- Folds (Treesitter activates them by buffer in treesitter.lua)
----------------------------------------------------------------------
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldmethod = 'manual'

----------------------------------------------------------------------
-- undo persistence
----------------------------------------------------------------------
local undodir = vim.fn.stdpath('state') .. '/undo'
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, 'p')
end
opt.undodir = undodir

----------------------------------------------------------------------
-- Proofreader's personal dictionary (zg/zw)
----------------------------------------------------------------------
local spell_dir = vim.fn.stdpath('config') .. '/spell'
if vim.fn.isdirectory(spell_dir) == 0 then
  vim.fn.mkdir(spell_dir, 'p')
end
vim.opt.spellfile = table.concat({
  spell_dir .. '/es.utf-8.add',
  spell_dir .. '/en.utf-8.add',
}, ',')

----------------------------------------------------------------------
-- Markdown: code block highlighting
----------------------------------------------------------------------
vim.g.markdown_fenced_languages = {
  'python',
  'lua',
  'bash=sh',
  'js=javascript',
  'ts=typescript',
  'css',
  'html',
  'json',
  'yaml',
}

-- Transparency command (:Transparency) and initial state
require('usr.core.transparency').setup()

--- Open the settings shortcut cheatsheet
vim.api.nvim_create_user_command('Cheatsheet', function()
  vim.cmd('edit ' .. vim.fn.fnameescape(vim.fn.stdpath('config') .. '/CHEATSHEET.md'))
end, { desc = 'Abrir el cheatsheet de atajos' })
