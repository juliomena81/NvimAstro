-- Tests: neotest with Python and Jest/Vitest adapters
return {
  'nvim-neotest/neotest',
  cmd = 'Neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-neotest/nvim-nio',
    'nvim-neotest/neotest-python',
    'haydenmeade/neotest-jest',
  },
  keys = {
    {
      '<leader>tt',
      function()
        require('neotest').run.run()
      end,
      desc = 'Test: correr el más cercano',
    },
    {
      '<leader>tf',
      function()
        require('neotest').run.run(vim.fn.expand('%'))
      end,
      desc = 'Test: correr archivo',
    },
    {
      '<leader>ts',
      function()
        require('neotest').run.stop()
      end,
      desc = 'Test: detener',
    },
    {
      '<leader>td',
      function()
        require('neotest').run.run({ strategy = 'dap' })
      end,
      desc = 'Test: depurar',
    },
    {
      '<leader>ta',
      function()
        require('neotest').run.attach()
      end,
      desc = 'Test: adjuntar',
    },
    {
      '<leader>to',
      function()
        require('neotest').output.open({ enter = true })
      end,
      desc = 'Test: ver salida',
    },
    {
      '<leader>tO',
      function()
        require('neotest').output_panel.toggle()
      end,
      desc = 'Test: panel de salida',
    },
    {
      '<leader>tS',
      function()
        require('neotest').summary.toggle()
      end,
      desc = 'Test: resumen',
    },
  },
  opts = function()
    return {
      adapters = {
        require('neotest-python')({
          dap = { justMyCode = false },
        }),
        require('neotest-jest')({
          jestCommand = 'npm test --',
          jestConfigFile = 'jest.config.js',
          env = { CI = true },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
    }
  end,
  config = function(_, opts)
    require('neotest').setup(opts)
  end,
}
