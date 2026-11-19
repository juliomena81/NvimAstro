-- fzf-lua: main search engine (files, grep, buffers, LSP, git...)
return {
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
  keys = {
    {
      '<leader>ff',
      function()
        require('fzf-lua').files()
      end,
      desc = 'Buscar archivos',
    },
    {
      '<leader>fg',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = 'Buscar texto (grep)',
    },
    {
      '<leader>fw',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = 'Buscar palabra bajo el cursor',
    },
    {
      '<leader>fW',
      function()
        require('fzf-lua').grep_visual()
      end,
      mode = 'x',
      desc = 'Buscar selección',
    },
    {
      '<leader>/',
      function()
        require('fzf-lua').blines()
      end,
      desc = 'Buscar en el buffer',
    },
    {
      '<leader>fb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = 'Buffers abiertos',
    },
    {
      '<leader>fr',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = 'Archivos recientes',
    },
    {
      '<leader>fc',
      function()
        require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })
      end,
      desc = 'Configuración de Neovim',
    },
    {
      '<leader>fh',
      function()
        require('fzf-lua').help_tags()
      end,
      desc = 'Ayuda de Neovim',
    },
    {
      '<leader>fk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = 'Atajos de teclado',
    },
    {
      '<leader>fd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = 'Diagnósticos del buffer',
    },
    {
      '<leader>fD',
      function()
        require('fzf-lua').diagnostics_workspace()
      end,
      desc = 'Diagnósticos del proyecto',
    },
    {
      '<leader>fs',
      function()
        require('fzf-lua').lsp_document_symbols()
      end,
      desc = 'Símbolos del documento',
    },
    {
      '<leader>fS',
      function()
        require('fzf-lua').lsp_workspace_symbols()
      end,
      desc = 'Símbolos del proyecto',
    },
    {
      '<leader>f.',
      function()
        require('fzf-lua').resume()
      end,
      desc = 'Reabrir última búsqueda',
    },
    {
      '<leader>gb',
      function()
        require('fzf-lua').git_branches()
      end,
      desc = 'Git: ramas',
    },
  },
  opts = function()
    return {
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = 'rounded',
        backdrop = 60,
        preview = {
          default = 'bat',
          border = 'rounded',
          layout = 'flex',
          flip_columns = 100,
        },
      },
      keymap = {
        builtin = {
          ['<M-Esc>'] = 'hide',
          ['<F1>'] = 'toggle-help',
          ['<F2>'] = 'toggle-fullscreen',
        },
        fzf = {
          ['ctrl-z'] = 'abort',
          ['ctrl-f'] = 'half-page-down',
          ['ctrl-b'] = 'half-page-up',
          ['alt-a'] = 'toggle-all',
          ['f3'] = 'toggle-preview-wrap',
          ['f4'] = 'toggle-preview',
        },
      },
      actions = {
        files = {
          ['default'] = require('fzf-lua').actions.file_edit_or_qf,
          ['ctrl-s'] = require('fzf-lua').actions.file_split,
          ['ctrl-v'] = require('fzf-lua').actions.file_vsplit,
          ['ctrl-t'] = require('fzf-lua').actions.file_tabedit,
        },
      },
      fzf_opts = {
        ['--ansi'] = true,
        ['--info'] = 'inline-right',
        ['--layout'] = 'reverse',
        ['--highlight-line'] = true,
      },
      previewers = {
        bat = {
          cmd = 'bat',
          args = '--color=always --style=numbers,changes',
        },
      },
    }
  end,
}
