-- neo-tree: file explorer
return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = 'Neotree',
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', desc = 'Explorador de archivos' },
    { '<leader>E', '<cmd>Neotree reveal<cr>', desc = 'Revelar archivo actual' },
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,

    filesystem = {
      filtered_items = {
        visible = true,
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = { '.DS_Store', 'thumbs.db', 'node_modules' },
      },
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
    },

    window = {
      width = 32,
      mappings = {
        ['<space>'] = 'none',
        ['l'] = 'open',
        ['h'] = 'close_node',
      },
    },

    default_component_configs = {
      indent = {
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
      },
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = '󰜌',
      },
      diagnostics = {
        symbols = {
          error = ' ',
          warn = ' ',
          hint = '󰌵 ',
          info = ' ',
        },
      },
    },
  },
}
