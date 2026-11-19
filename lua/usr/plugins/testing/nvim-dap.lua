-- Debugging: nvim-dap + dap-ui + Mason adapters (debugpy)
return {
  'mfussenegger/nvim-dap',
  keys = {
    { '<leader>db', '<cmd>DapToggleBreakpoint<cr>', desc = 'DAP: breakpoint' },
    { '<leader>dc', '<cmd>DapContinue<cr>', desc = 'DAP: continuar' },
    { '<leader>di', '<cmd>DapStepInto<cr>', desc = 'DAP: paso dentro' },
    { '<leader>do', '<cmd>DapStepOver<cr>', desc = 'DAP: paso sobre' },
    { '<leader>dO', '<cmd>DapStepOut<cr>', desc = 'DAP: salir del paso' },
    {
      '<leader>du',
      function()
        require('dapui').toggle()
      end,
      desc = 'DAP: UI',
    },
    {
      '<leader>de',
      function()
        require('dapui').eval()
      end,
      mode = { 'n', 'v' },
      desc = 'DAP: evaluar',
    },
    {
      '<leader>dr',
      function()
        require('dap').repl.open()
      end,
      desc = 'DAP: REPL',
    },
    {
      '<leader>dl',
      function()
        require('dap').run_last()
      end,
      desc = 'DAP: repetir última sesión',
    },
  },
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({})

    -- Mason installs and configures the adapters (python | debugpy)
    require('mason-nvim-dap').setup({
      ensure_installed = { 'python' },
      automatic_installation = true,
      handlers = {},
    })

    -- If the adapter is not defined, use Mason's debugpy or python3
    if not dap.adapters.python then
      dap.adapters.python = {
        type = 'executable',
        command = 'python3',
        args = { '-m', 'debugpy.adapter' },
      }
    end

    dap.configurations.python = {
      {
        type = 'python',
        request = 'launch',
        name = 'Lanzar archivo actual',
        program = '${file}',
        pythonPath = function()
          return vim.fn.exepath('python3')
        end,
      },
      {
        type = 'python',
        request = 'launch',
        name = 'Lanzar con argumentos',
        program = '${file}',
        args = function()
          local input = vim.fn.input('Argumentos: ')
          return vim.split(input, ' ', { trimempty = true })
        end,
        console = 'integratedTerminal',
      },
    }

    -- Signs
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DiagnosticError' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DiagnosticWarn' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DiagnosticWarn', linehl = 'Visual' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DiagnosticInfo' })

    -- Open/close UI automatically
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
}
