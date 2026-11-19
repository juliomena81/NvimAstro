-- Diffview: diffs, history and revisions
return {
  'sindrets/diffview.nvim',
  cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFileHistory' },
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Git: diff de la rama' },
    { '<leader>gq', '<cmd>DiffviewClose<cr>', desc = 'Git: cerrar diff' },
    { '<leader>gH', '<cmd>DiffviewFileHistory %<cr>', desc = 'Git: historial del archivo' },
    { '<leader>gX', '<cmd>DiffviewFileHistory<cr>', desc = 'Git: historial del proyecto' },
  },
  opts = {},
}
