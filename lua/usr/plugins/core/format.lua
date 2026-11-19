-- Format when saving: conform.nvim
-- Lua → stylua
-- Python → ruff (imports + format)
-- Web / Markdown → prettier
-- Shell → shfmt
-- Astro → Astro LSP (uses prettier + its plugin)

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>cf',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end,
      mode = { 'n', 'v' },
      desc = 'Formatear buffer / selección',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },

      python = { 'ruff_organize_imports', 'ruff_format' },

      css = { 'prettier' },
      scss = { 'prettier' },
      less = { 'prettier' },
      html = { 'prettier' },
      json = { 'prettier' },
      jsonc = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      javascript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      svelte = { 'prettier' },
      vue = { 'prettier' },

      sh = { 'shfmt' },
      bash = { 'shfmt' },
    },

    default_format_opts = { timeout_ms = 3000, lsp_format = 'fallback' },

    format_on_save = function(bufnr)
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return nil
      end
      return { timeout_ms = 3000, lsp_format = 'fallback' }
    end,

    notify_on_error = true,

    formatters = {
      prettier = {
        prepend_args = { '--print-width', '100', '--prose-wrap', 'preserve' },
      },
      ruff_format = { prepend_args = { '--line-length', '100' } },
      ruff_organize_imports = { prepend_args = { '--line-length', '100' } },
      stylua = { prepend_args = { '--indent-type', 'Spaces', '--indent-width', '2' } },
    },
  },
}
