---@type LazySpec
return {
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    dependencies = {
      {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
      },
      -- notification
      'j-hui/fidget.nvim',
      {
        'williamboman/mason.nvim',
        opts = {
          ui = {
            border = 'rounded',
            icons = {
              package_installed = '✓',
              package_pending = '➜',
              package_uninstalled = '✗',
            },
          },
        },
      },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
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
            map(
              'gd',
              require('typescript-tools.api').go_to_source_definition,
              '[G]oto [D]efinition'
            )
          else
            map('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
          end

          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_document_symbols, '[D]ocument Symbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          vim.api.nvim_create_autocmd('CursorHold', {
            buffer = bufnr,
            desc = 'LSP: show diagnostics on CursorHold',
            callback = function()
              for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
                if vim.api.nvim_win_get_config(winid).relative ~= '' then
                  return
                end
              end

              local line_num = vim.api.nvim__buf_stats(bufnr).line_num
              local diagnostics = vim.diagnostic.get(bufnr, { lnum = line_num })

              if #diagnostics > 0 then
                vim.diagnostic.open_float(nil, {
                  focusable = false,
                  close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
                  border = 'rounded',
                  source = 'always',
                  prefix = ' ',
                })
              end
            end,
          })

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

          if client and client.server_capabilities.inlayHintProvider then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = nil })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local servers = {
        tsserver = {},
        ['eslint-lsp'] = {},
        ['svelte-language-server'] = {},
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              cargo = {
                buildScripts = {
                  enable = true,
                },
              },
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
        texlab = {},
        yamlls = {
          yaml = {
            schemas = {
              ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
            },
          },
        },
      }

      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua',
        'protolint',
        'checkmake',
        'markdownlint',
        'asmfmt',
        'prettierd',
        'prettier',
        'shellcheck',
      })

      require('mason-tool-installer').setup {
        ensure_installed = ensure_installed,
        automatic_installation = true,
        auto_update = true,
        run_on_start = true,
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities =
        vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      capabilities = vim.tbl_deep_extend('force', capabilities, {
        textDocument = { foldingRange = { dynamicRegistration = false, lineFoldingOnly = true } },
      })

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities =
              vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})

            require('lspconfig')[server_name].setup(server)
          end,
        },
      }

      vim.o.foldcolumn = '0'
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      -- vim.o.fold
      vim.o.foldenable = true

      require('ufo').setup {
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = (' 󰁂 %d '):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              -- str width returned from truncate() may less than 2nd argument, need padding
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          table.insert(newVirtText, { suffix, 'MoreMsg' })
          return newVirtText
        end,
        preview = {
          win_config = {
            winblend = 0,
            maxheight = 80,
          },
        },
      }

      local signs = {
        [vim.diagnostic.severity.ERROR] = ' ',
        [vim.diagnostic.severity.WARN] = ' ',
        [vim.diagnostic.severity.HINT] = '󰌵',
        [vim.diagnostic.severity.INFO] = ' ',
      }

      local config = {
        virtual_text = {
          prefix = function(diagnostic)
            return ' ' .. signs[diagnostic.severity] or signs[vim.diagnostic.severity.INFO]
          end,
          spacing = 4,
          suffix = ' ',
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.HINT] = '',
            [vim.diagnostic.severity.INFO] = '',
          },
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

      vim.lsp.handlers['textDocument/hover'] =
        vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
      vim.lsp.handlers['textDocument/signatureHelp'] =
        vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
      vim.lsp.handlers['textDocument/publishDiagnostics'] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, config)
    end,
  },
}
