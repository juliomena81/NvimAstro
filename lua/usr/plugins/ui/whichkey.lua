-- which-key: show all shortcuts when pressing <leader>

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Atajos del buffer',
    },
  },
  opts = {
    preset = 'classic',
    delay = 300,
    icons = { breadcrumb = '»', separator = '➜', group = '+' },
    spec = {
      { '<leader>b', group = 'Buffer' },
      { '<leader>c', group = 'Código' },
      { '<leader>d', group = 'Debug (DAP)' },
      { '<leader>f', group = 'Buscar (fzf-lua)' },
      { '<leader>g', group = 'Git' },
      { '<leader>m', group = 'Markdown' },
      { '<leader>q', group = 'Salir' },
      { '<leader>t', group = 'Testing' },
      { '<leader>u', group = 'Alternar' },
      { '<leader>w', group = 'Ventanas' },
      { '<leader>x', group = 'Diagnósticos' },
      { '<leader>l', group = 'Lazy' },
    },
  },
}
