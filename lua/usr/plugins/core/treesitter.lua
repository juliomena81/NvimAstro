-- Treesitter (`main` branch, compatible with Neovim 0.12)
--
-- Requirements: tree-sitter-cli >= 0.26, tar, curl, and a C compiler.
-- Does not support lazy loading; `build` updates parsers when running `:Lazy update`.

local parsers = {
  -- Neovim / config
  'lua',
  'luadoc',
  'vim',
  'vimdoc',
  'query',
  -- Web
  'css',
  'scss',
  'html',
  'javascript',
  'typescript',
  'tsx',
  'astro',
  'svelte',
  'json',
  'yaml',
  'toml',
  -- Python / shell / infra
  'python',
  'bash',
  'dockerfile',
  -- Documentation and utilities
  'markdown',
  'markdown_inline',
  'regex',
  'gitignore',
  'gitcommit',
  'diff',
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      if vim.fn.executable('tree-sitter') == 1 then
        require('nvim-treesitter').install(parsers)
      else
        vim.schedule(function()
          vim.notify(
            'Treesitter: falta `tree-sitter-cli` (sudo pacman -S tree-sitter-cli)',
            vim.log.levels.WARN,
            { title = 'nvim-treesitter' }
          )
        end)
      end

      -- Syntax-based highlighting + folding per buffer
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('UserTreesitter', { clear = true }),
        desc = 'Activar Treesitter por filetype',
        callback = function(event)
          local ok = pcall(vim.treesitter.start, event.buf)
          if ok then
            vim.wo.foldmethod = 'expr'
            vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
          end
        end,
      })
    end,
  },

  ----------------------------------------------------------------------
  -- Syntax-aware text objects (af/if, ac/ic, aa/ia, etc.) and navigation ]f/[f
  ----------------------------------------------------------------------
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    init = function()
      vim.g.no_plugin_maps = true -- Prevents conflicts with built-in filetype plugins (ftplugins)
    end,
    config = function()
      require('nvim-treesitter-textobjects').setup({
        select = {
          lookahead = true,
          selection_modes = {
            ['@function.outer'] = 'V',
            ['@class.outer'] = 'V',
          },
          include_surrounding_whitespace = false,
        },
        move = { set_jumps = true },
      })

      local select = require('nvim-treesitter-textobjects.select')
      local move = require('nvim-treesitter-textobjects.move')
      local map = vim.keymap.set

      local objects = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['ab'] = '@block.outer',
        ['ib'] = '@block.inner',
      }

      for lhs, query in pairs(objects) do
        map({ 'x', 'o' }, lhs, function()
          select.select_textobject(query, 'textobjects')
        end, { desc = 'Textobject ' .. query })
      end

      map({ 'n', 'x', 'o' }, ']f', function()
        move.goto_next_start('@function.outer', 'textobjects')
      end, { desc = 'Siguiente función' })
      map({ 'n', 'x', 'o' }, '[f', function()
        move.goto_previous_start('@function.outer', 'textobjects')
      end, { desc = 'Función anterior' })
      map({ 'n', 'x', 'o' }, ']c', function()
        move.goto_next_start('@class.outer', 'textobjects')
      end, { desc = 'Siguiente clase' })
      map({ 'n', 'x', 'o' }, '[c', function()
        move.goto_previous_start('@class.outer', 'textobjects')
      end, { desc = 'Clase anterior' })
    end,
  },
}
