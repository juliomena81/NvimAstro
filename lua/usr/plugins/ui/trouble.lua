-- Trouble: diagnostics, symbols, references and quickfix
return {
  'folke/trouble.nvim',
  cmd = 'Trouble',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnósticos (proyecto)' },
    {
      '<leader>xX',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Diagnósticos (buffer)',
    },
    { '<leader>xs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = 'Símbolos' },
    {
      '<leader>xl',
      '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
      desc = 'Referencias LSP',
    },
    { '<leader>xq', '<cmd>Trouble qflist toggle<cr>', desc = 'Lista rápida' },
  },
  opts = {
    focus = false,
    auto_close = true,
    auto_preview = true,
    use_diagnostic_signs = true,
    win = { border = 'rounded' },
  },
}
