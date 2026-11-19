-- Bootstrap and lazy.nvim configuration
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  local out =
    vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'No se pudo clonar lazy.nvim:\n', 'ErrorMsg' },
      { out },
      { '\nPulsa una tecla para salir…' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  spec = {
    { import = 'usr.plugins.core' },
    { import = 'usr.plugins.ui' },
    { import = 'usr.plugins.git' },
    { import = 'usr.plugins.navigation' },
    { import = 'usr.plugins.testing' },
    { import = 'usr.plugins.web' },
    { import = 'usr.plugins.utils' },
    { import = 'usr.plugins.extras' },
  },

  defaults = {
    lazy = false, -- specs use event/cmd/keys/ft to defer
    version = false, -- last commit
  },

  install = { colorscheme = { 'catppuccin', 'habamax' } },

  checker = { enabled = false },
  change_detection = { notify = false },
  ui = { border = 'rounded' },

  performance = {
    cache = { enabled = true },
    rtp = {
      disabled_plugins = {
        'gzip',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },

  git = { timeout = 300 },
  rocks = { enabled = false },
}, {
  lockfile = vim.fn.stdpath('config') .. '/lazy-lock.json',
})
