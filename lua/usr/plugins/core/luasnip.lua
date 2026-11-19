-- Snippets: LuaSnip + friendly-snippets
return {
  'L3MON4D3/LuaSnip',
  lazy = false,
  build = 'make install_jsregexp', -- Regex transformations in snippets
  dependencies = { 'rafamadriz/friendly-snippets' },
  config = function()
    local ls = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load()

    ls.config.set_config({
      history = true,
      update_events = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
      store_selection_keys = '<Tab>',
    })

    -- HTML snippets within JSX/TSX (Astro/Svelte also benefit)
    ls.filetype_extend('javascriptreact', { 'html' })
    ls.filetype_extend('typescriptreact', { 'html' })

    vim.keymap.set({ 'i', 's' }, '<Tab>', function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes('<Tab>', true, false, true),
          'n',
          false
        )
      end
    end, { silent = true, desc = 'Snippet: expandir/saltar' })

    vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      else
        vim.api.nvim_feedkeys(
          vim.api.nvim_replace_termcodes('<S-Tab>', true, false, true),
          'n',
          false
        )
      end
    end, { silent = true, desc = 'Snippet: saltar atrás' })
  end,
}
