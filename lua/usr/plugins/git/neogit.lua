-- Neogit: Magit-style Git UI (commit, stage, push/pull)
return {
  'NeogitOrg/neogit',
  cmd = 'Neogit',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
  },
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Git: Neogit (estado)' },
    { '<leader>gc', '<cmd>Neogit commit<cr>', desc = 'Git: commit' },
  },
  opts = {
    kind = 'split',
    integrations = { diffview = true },
    signs = {
      section = { '', '' },
      item = { '', '' },
      hunk = { '', '' },
    },
  },
}
