-- Markdown rendered inside the buffer (titles, tables, checkboxes...)
return {
  'MeanderingProgrammer/render-markdown.nvim',
  ft = { 'markdown', 'opencode_output' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    {
      '<leader>mr',
      '<cmd>RenderMarkdown toggle<cr>',
      ft = 'markdown',
      desc = 'Markdown: render en buffer',
    },
  },
  opts = {
    file_types = { 'markdown', 'opencode_output' },
    anti_conceal = { enabled = false },
    heading = { sign = false },
    code = { sign = false, width = 'block', left_pad = 1, right_pad = 1 },
    bullet = { enabled = true },
    checkbox = { enabled = true },
    link = { enabled = true },
    quote = { enabled = true },
    table = { enabled = true },
    completions = { lsp = { enabled = true } },
  },
}
