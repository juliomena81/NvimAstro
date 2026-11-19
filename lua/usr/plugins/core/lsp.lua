-- LSP: servers, diagnostics and shortcuts.
-- New Neovim 0.11+ API: vim.lsp.config() + vim.lsp.enable().

local servers = {
  -- Lua / infra
  'lua_ls',
  'bashls',
  'dockerls',
  'yamlls',
  'jsonls',
  -- Web
  'ts_ls',
  'cssls',
  'html',
  'emmet_language_server',
  'tailwindcss',
  'astro',
  'svelte',
  -- Python
  'pyright',
  'ruff',
  -- Documentation
  'marksman',
}

-- Formatting/linting tools
local tools = {
  'stylua',
  'prettier',
  'ruff',
  'shfmt',
  'shellcheck',
  'hadolint',
  'svelte-language-server', -- mason-lspconfig does not map the `svelte` server
}

-- TypeScript SDK for Astro/Svelte: local project -> Mason -> global npm
local function typescript_sdk(root_dir)
  local util = require('lspconfig.util')
  local tsdk = util.get_typescript_server_path(root_dir)
  if tsdk and tsdk ~= '' then
    return tsdk
  end

  local mason_ts = vim.fn.stdpath('data')
    .. '/mason/packages/typescript-language-server/node_modules/typescript/lib'
  if vim.fn.isdirectory(mason_ts) == 1 then
    return mason_ts
  end

  local npm_root = vim.fn.systemlist('npm root -g')
  if vim.v.shell_error == 0 and npm_root[1] then
    return npm_root[1] .. '/typescript/lib'
  end
  return nil
end

-- Detects .venv (pyright)
local function detect_venv()
  local found = vim.fs.find({ '.venv', 'venv' }, {
    path = vim.fn.getcwd(),
    upward = true,
    type = 'directory',
  })[1]
  if not found then
    return nil
  end
  return vim.fs.dirname(found), vim.fs.basename(found)
end

return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'Mason',
    dependencies = {
      {
        'mason-org/mason.nvim',
        opts = {
          ui = { border = 'rounded' },
          max_concurrent_installers = 4,
        },
      },
      {
        'mason-org/mason-lspconfig.nvim',
        opts = {
          ensure_installed = servers,
          automatic_enable = false,
        },
      },
      {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
          ensure_installed = tools,
          auto_update = false,
          run_on_start = true,
        },
      },
      -- Extended capabilities for all servers
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      ------------------------------------------------------------------
      -- Diagnostics
      ------------------------------------------------------------------
      vim.diagnostic.config({
        severity_sort = true,
        update_in_insert = false,
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
          },
        },
        virtual_text = { spacing = 4, source = 'if_many', prefix = '●' },
        float = { border = 'rounded', source = true, focusable = false, style = 'minimal' },
        jump = { float = true },
      })

      ------------------------------------------------------------------
      -- Common capabilities (nvim-cmp)
      ------------------------------------------------------------------
      vim.lsp.config('*', {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      })

      ------------------------------------------------------------------
      -- Server-specific settings
      ------------------------------------------------------------------
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            runtime = { version = 'LuaJIT' },
            workspace = {
              checkThirdParty = false,
              library = vim.api.nvim_get_runtime_file('', true),
            },
            diagnostics = {
              globals = { 'vim', 'Snacks', 'harpoon' },
              disable = { 'missing-fields' },
            },
            telemetry = { enable = false },
            format = { enable = false }, -- stylua se encarga
            hint = { enable = true },
          },
        },
      })

      local venv_path, venv_name = detect_venv()
      vim.lsp.config('pyright', {
        settings = {
          python = {
            venvPath = venv_path,
            venv = venv_name,
            analysis = {
              typeCheckingMode = 'standard',
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
      })

      vim.lsp.config('ruff', {
        init_options = {
          settings = {
            fixAll = true,
            organizeImports = true,
            showSyntaxErrors = false,
            lineLength = 100,
            lint = {
              select = { 'E', 'F', 'I', 'UP', 'B', 'SIM' },
              ignore = { 'E501' },
            },
          },
        },
      })

      -- CSS: ignores Tailwind at-rules (@tailwind, @apply, @theme, etc.)
      vim.lsp.config('cssls', {
        settings = {
          css = { validate = true, lint = { unknownAtRules = 'ignore' } },
          scss = { validate = true, lint = { unknownAtRules = 'ignore' } },
          less = { validate = true, lint = { unknownAtRules = 'ignore' } },
        },
      })

      -- Tailwind: classes in Astro/JSX/CSS/Markdown
      vim.lsp.config('tailwindcss', {
        settings = {
          tailwindCSS = {
            includeLanguages = { astro = 'html', plaintext = 'html' },
            validate = true,
            lint = {
              cssConflict = 'warning',
              invalidApply = 'error',
              invalidScreen = 'error',
              invalidVariant = 'error',
            },
            experimental = {
              classRegex = { 'class:list=(["\'])(.*?)\\1' },
            },
            codeActions = { organizeImports = true },
          },
        },
      })

      vim.lsp.config('emmet_language_server', {
        filetypes = {
          'astro',
          'css',
          'html',
          'javascriptreact',
          'scss',
          'svelte',
          'typescriptreact',
          'vue',
        },
        init_options = {
          showSuggestionsAsSnippets = true,
          preferences = { 'css.intellisense.completions' },
        },
      })

      vim.lsp.config('yamlls', {
        settings = { yaml = { keyOrdering = false, validate = true } },
      })

      vim.lsp.config('jsonls', {
        settings = { json = { validate = { enable = true } } },
      })

      vim.lsp.config('marksman', {
        root_markers = { '.marksman.toml', '.git' },
      })

      -- Astro: the server aborts on startup if a valid `tsdk` is not found
      vim.lsp.config('astro', {
        before_init = function(_, config)
          local tsdk = typescript_sdk(config.root_dir)
          if tsdk == nil then
            return
          end
          config.init_options = config.init_options or {}
          config.init_options.typescript = config.init_options.typescript or {}
          config.init_options.typescript.tsdk = tsdk
        end,
      })

      -- Svelte: points to the project’s TypeScript or the one from Mason
      vim.lsp.config('svelte', {
        before_init = function(_, config)
          local tsdk = typescript_sdk(config.root_dir)
          if tsdk == nil then
            return
          end
          config.init_options = config.init_options or {}
          config.init_options.typescript = { tsdk = tsdk }
        end,
      })

      ------------------------------------------------------------------
      -- Enable servers
      ------------------------------------------------------------------
      vim.lsp.enable(servers)

      ------------------------------------------------------------------
      -- Buffer-specific shortcuts triggered when a server connects
      ------------------------------------------------------------------
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspAttach', { clear = true }),
        desc = 'Atajos LSP',
        callback = function(event)
          local buf = event.buf
          local function map(lhs, rhs, desc)
            vim.keymap.set('n', lhs, rhs, { buffer = buf, desc = desc, silent = true })
          end

          map('gd', vim.lsp.buf.definition, 'Ir a definición')
          map('gD', vim.lsp.buf.declaration, 'Ir a declaración')
          map('gy', vim.lsp.buf.type_definition, 'Ir al tipo')
          map('gi', vim.lsp.buf.implementation, 'Ir a implementación')
          map('gr', function()
            require('fzf-lua').lsp_references()
          end, 'Referencias')
          map('K', vim.lsp.buf.hover, 'Documentación')
          map('gK', vim.lsp.buf.signature_help, 'Firma de la función')
          map('<leader>ca', vim.lsp.buf.code_action, 'Acciones de código')
          map('<leader>cr', vim.lsp.buf.rename, 'Renombrar símbolo')
          map('<leader>rn', vim.lsp.buf.rename, 'Renombrar símbolo')
          map('<leader>cd', vim.diagnostic.open_float, 'Diagnóstico de la línea')
          map('<leader>cs', function()
            require('fzf-lua').lsp_document_symbols()
          end, 'Símbolos del documento')
        end,
      })
    end,
  },
}
