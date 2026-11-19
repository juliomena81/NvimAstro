-- Displays the color of Tailwind classes in the nvim-cmp menu
return {
  'roobert/tailwindcss-colorizer-cmp.nvim',
  event = { 'InsertEnter' },
  dependencies = { 'hrsh7th/nvim-cmp' },
  opts = {
    color_square_width = 2,
  },
}
