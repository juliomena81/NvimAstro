-- Home screen
return {
  'goolord/alpha-nvim',
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require('alpha')
    local dashboard = require('alpha.themes.dashboard')

    dashboard.section.header.val = {
      [[                               __                ]],
      [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      [[                                                 ]],
    }

    dashboard.section.buttons.val = {
      dashboard.button('f', '󰈞  Buscar archivos', ':FzfLua files<CR>'),
      dashboard.button('r', '󰄉  Recientes', ':FzfLua oldfiles<CR>'),
      dashboard.button('e', '󰙅  Nuevo archivo', ':ene <BAR> startinsert<CR>'),
      dashboard.button('s', '󰒲  Lazy', ':Lazy<CR>'),
      dashboard.button('q', '󰅚  Salir', ':qa<CR>'),
    }

    dashboard.section.footer.val = 'Neovim 0.12 · <leader> para ver los atajos'

    alpha.setup(dashboard.opts)
  end,
}
