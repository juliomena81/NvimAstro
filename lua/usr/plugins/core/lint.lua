-- Linting with nvim-lint
return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      dockerfile = { 'hadolint' },
    }

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = vim.api.nvim_create_augroup('UserLint', { clear = true }),
      desc = 'Ejecutar linters',
      callback = function()
        lint.try_lint()
      end,
    })
  end,
}
