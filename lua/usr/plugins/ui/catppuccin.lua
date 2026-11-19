-- Theme: Catppuccin Mocha
local flavour = 'mocha'

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  lazy = false,
  priority = 1000,
  opts = {
    flavour = flavour,
    background = { light = 'latte', dark = flavour },
    transparent_background = false,
    term_colors = true,
    dim_inactive = { enabled = false, shade = 'dark', percentage = 0.15 },
    styles = {
      comments = { 'italic' },
      conditionals = { 'italic' },
      keywords = { 'italic' },
    },
    integrations = {
      alpha = true,
      cmp = true,
      dap = true,
      dap_ui = true,
      diffview = true,
      fzf = true,
      gitsigns = true,
      harpoon = true,
      lsp_trouble = true,
      mason = true,
      neogit = true,
      neotest = true,
      neotree = true,
      nvim_surround = true,
      render_markdown = true,
      snacks = true,
      treesitter = true,
      which_key = true,
      -- lualine = { all = { normal = { b = { bg = 'NONE' } } } },
      native_lsp = {
        enabled = true,
        underlines = {
          errors = { 'undercurl' },
          hints = { 'undercurl' },
          warnings = { 'undercurl' },
          information = { 'undercurl' },
        },
      },
    },
  },
  config = function(_, opts)
    require('catppuccin').setup(opts)
    vim.cmd.colorscheme('catppuccin')
  end,
}
