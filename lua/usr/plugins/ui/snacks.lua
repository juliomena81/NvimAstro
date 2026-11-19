-- snacks.nvim: Utilities that don't clash with fzf-lua/neo-tree/toggleterm.
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false, -- necesario para vim.notify y los módulos de UI
  opts = {
    input = { enabled = true },
    indent = { enabled = true },
    notifier = { enabled = true, timeout = 3000 },
    words = { enabled = true },
    dim = { enabled = true },
    zen = { enabled = true },
    scroll = { enabled = true },
    animate = { enabled = true },
    quickfile = { enabled = true },
    bufdelete = { enabled = true },
    bigfile = { enabled = true },
    gh = { enabled = true },
    layout = { enabled = true },
    rename = { enabled = true },
    toggle = { enabled = true },
    scope = { enabled = false },

    image = { enabled = false },
    explorer = { enabled = false },
    dashboard = { enabled = false },
    git = { enabled = false },
    gitbrowse = { enabled = false },
    lazygit = { enabled = false },
    terminal = { enabled = false },
    picker = { enabled = false },
    statuscolumn = { enabled = false },

    styles = {
      notification = { wo = { wrap = true } },
    },
  },
  keys = {
    {
      '<leader>n',
      function()
        Snacks.notifier.show_history()
      end,
      desc = 'Historial de notificaciones',
    },
    {
      '<leader>nD',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Descartar notificaciones',
    },
  },
}
