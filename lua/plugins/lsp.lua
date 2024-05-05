return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
      { 'folke/neodev.nvim', opts = {} },
      {
        'pmizio/typescript-tools.nvim',
        dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
      },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          local bufnr = event.buf
          local filetype = vim.api.nvim_get_option_value('filetype', { buf = bufnr })
          if
            filetype == 'typescript'
            or filetype == 'typescriptreact'
            or filetype == 'typescript.tsx'
            or filetype == 'javascript'
            or filetype == 'javascriptreact'
          then
            map('gd', require('typescript-tools.api').go_to_source_definition, bufnr)
          else
            map('gd', vim.lsp.buf.definition, bufnr)
          end

          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = 0 }, { bufnr = 0 })
          end, '[T]oggle Inlay [H]ints')
        end,
      })

      local servers = {
        prettierd = {},
        tsserver = {},
        ['eslint-lsp'] = {},
        ['svelte-language-server'] = {},
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              check = {
                command = 'clippy',
              },
            },
          },
        },
        dockerls = {},
        ['terraform-ls'] = {},
        clangd = {
          cmd = {
            'clangd',
            '--header-insertion=never',
            '-j',
            '24',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--rename-file-limit=0',
            '--background-index',
            '--background-index-priority=normal',
          },
          filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        },
        ['clang-format'] = {},
        checkmake = {},
        lua_ls = {
          settings = {
            Lua = {
              hint = {
                enable = true,
              },
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
        ['asm-lsp'] = {},
        cssls = {},
        tailwindcss = {},
        prismals = {},
        html = {},
        omnisharp = {},
        jsonls = {},
        pylsp = {},
        bashls = {},
        typos_lsp = {
          init_options = {
            diagnosticSeverity = 'hint',
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'checkmake',
        'markdownlint',
        'asmfmt',
        'shellcheck',
      })

      require('mason-tool-installer').setup { ensure_installed = ensure_installed, automatic_installation = true }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      local signs = {
        [vim.diagnostic.severity.ERROR] = '',
        [vim.diagnostic.severity.WARN] = '',
        [vim.diagnostic.severity.HINT] = '󰌵',
        [vim.diagnostic.severity.INFO] = '',
      }

      local config = {
        virtual_text = {
          prefix = function(diagnostic)
            return ' ' .. signs[diagnostic.severity] or signs[vim.diagnostic.severity.INFO]
          end,
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = true,
          style = 'minimal',
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      }

      vim.diagnostic.config(config)

      vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'single' })
      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
      vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        underline = true,
        update_in_insert = true,
        virtual_text = { spacing = 4, prefix = config.virtual_text.prefix },
        severity_sort = true,
      })
    end,
  },
}
