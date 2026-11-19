-- Floating terminal (Ctrl+t)
-- :Term: command
return {
  'akinsho/toggleterm.nvim',
  version = '*',
  cmd = { 'ToggleTerm', 'TermExec', 'Term' },
  opts = {
    size = 20,
    open_mapping = false,
    hide_numbers = true,
    shade_terminals = true,
    direction = 'float',
    float_opts = {
      border = 'rounded',
      winblend = 3,
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    vim.api.nvim_create_user_command('Term', function()
      require('toggleterm').toggle()
    end, { desc = 'Abrir/cerrar terminal flotante' })

    function _G.set_terminal_keymaps()
      local bufopts = { buffer = 0 }
      vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], bufopts)
      vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], bufopts)
      vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], bufopts)
      vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], bufopts)
      vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], bufopts)
    end

    vim.api.nvim_create_autocmd('TermOpen', {
      group = vim.api.nvim_create_augroup('UserTermOpen', { clear = true }),
      callback = function()
        set_terminal_keymaps()
      end,
    })
  end,
}
