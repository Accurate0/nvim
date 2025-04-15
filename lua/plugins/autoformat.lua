---@type LazySpec
return {
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      {
        '<leader>tf',
        function()
          -- If autoformat is currently disabled for this buffer,
          -- then enable it, otherwise disable it
          if vim.b.disable_autoformat then
            vim.cmd 'FormatEnable'
            vim.notify 'Enabled autoformat for current buffer'
          else
            vim.cmd 'FormatDisable!'
            vim.notify 'Disabled autoformat for current buffer'
          end
        end,
        desc = 'Toggle autoformat for current buffer',
      },
      {
        '<leader>tF',
        function()
          -- If autoformat is currently disabled globally,
          -- then enable it globally, otherwise disable it globally
          if vim.g.disable_autoformat then
            vim.cmd 'FormatEnable'
            vim.notify 'Enabled autoformat globally'
          else
            vim.cmd 'FormatDisable'
            vim.notify 'Disabled autoformat globally'
          end
        end,
        desc = 'Toggle autoformat globally',
      },
    },
    config = function(_, opts)
      require('conform').setup(opts)

      vim.api.nvim_create_user_command('FormatDisable', function(args)
        if args.bang then
          -- :FormatDisable! disables autoformat for this buffer only
          vim.b.disable_autoformat = true
        else
          -- :FormatDisable disables autoformat globally
          vim.g.disable_autoformat = true
        end
      end, {
        desc = 'Disable autoformat-on-save',
        bang = true, -- allows the ! variant
      })

      vim.api.nvim_create_user_command('FormatEnable', function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = 'Re-enable autoformat-on-save',
      })
    end,
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        local disable_filetypes = { c = true, cpp = true, html = true }
        return {
          timeout_ms = 500,
          format_on_save = not disable_filetypes[vim.bo[bufnr].filetype],
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        tex = { 'latexindent' },
        asm = { 'asmfmt' },
        ['javascript'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['javascriptreact'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['typescript'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['typescriptreact'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['vue'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['css'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['scss'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['less'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['html'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['json'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['jsonc'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['yaml'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['graphql'] = { 'prettierd', 'prettier', stop_after_first = true },
        ['handlebars'] = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}
