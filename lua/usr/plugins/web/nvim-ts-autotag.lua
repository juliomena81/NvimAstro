-- Automatic closing and renaming of HTML/JSX/Astro tags
return {
  'windwp/nvim-ts-autotag',
  ft = {
    'html',
    'javascript',
    'javascriptreact',
    'typescriptreact',
    'svelte',
    'astro',
    'xml',
    'vue',
  },
  opts = {
    opts = {
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = false,
    },
  },
}
