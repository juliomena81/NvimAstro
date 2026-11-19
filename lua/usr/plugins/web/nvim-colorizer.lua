-- Hex/rgb colors in the buffer
return {
  'catgoose/nvim-colorizer.lua',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    filetypes = { '*' },
    user_default_options = {
      names = true,
      rgb_fn = true,
      tailwind = 'normal',
    },
  },
}
