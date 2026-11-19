-- gitsigns: signs, blame, and stage/reset by hunk
return {
  'lewis6991/gitsigns.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
      untracked = { text = '┆' },
    },
    current_line_blame = false,
    current_line_blame_opts = { delay = 500, virt_text_pos = 'eol' },
    preview_config = { border = 'rounded' },
    on_attach = function(bufnr)
      local gs = require('gitsigns')
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
      end

      -- Navigation
      map('n', ']h', function()
        gs.nav_hunk('next')
      end, 'Hunk siguiente')
      map('n', '[h', function()
        gs.nav_hunk('prev')
      end, 'Hunk anterior')
      map('n', '<leader>gn', function()
        gs.nav_hunk('next')
      end, 'Git: hunk siguiente')
      map('n', '<leader>gp', function()
        gs.nav_hunk('prev')
      end, 'Git: hunk anterior')

      -- Stage / reset
      map('n', '<leader>gs', gs.stage_hunk, 'Git: stage hunk')
      map('n', '<leader>gr', gs.reset_hunk, 'Git: reset hunk')
      map('v', '<leader>gs', function()
        gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, 'Git: stage selección')
      map('v', '<leader>gr', function()
        gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
      end, 'Git: reset selección')
      map('n', '<leader>gS', gs.stage_buffer, 'Git: stage buffer')
      map('n', '<leader>gR', gs.reset_buffer, 'Git: reset buffer')

      -- Information
      map('n', '<leader>gl', function()
        gs.blame_line({ full = true })
      end, 'Git: blame línea')
      map('n', '<leader>gL', gs.toggle_current_line_blame, 'Git: blame en la línea')
      map('n', '<leader>gh', gs.preview_hunk, 'Git: previsualizar hunk')
      map('n', '<leader>gt', gs.toggle_deleted, 'Git: alternar borrados')
      map('n', '<leader>gD', gs.diffthis, 'Git: diff del buffer')
      map('n', '<leader>gB', function()
        gs.diffthis('~')
      end, 'Git: diff contra HEAD~')
      map({ 'o', 'x' }, 'ih', gs.select_hunk, 'Seleccionar hunk')
    end,
  },
}
