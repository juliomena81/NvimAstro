-- Structure:
--   lua/usr/core/     options, shortcuts, autocmds, transparency
--   lua/usr/plugins/  Lazy specs by domain (core, UI, Git, …)
--
-- Quick settings:
--   :Transparency        toggles transparent background
--   :checkhealth         general diagnostics
--   <leader>l            Lazy

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Transparent background enabled by default
vim.g.transparent = true

require('usr.core.setup')
require('usr.core.autocmds')
require('usr.core.keymaps')
require('usr.lazy')
