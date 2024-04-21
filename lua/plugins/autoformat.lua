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
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        tex = { 'latexindent' },
        asm = { 'asmfmt' },
        ['javascript'] = { { 'prettierd', 'prettier' } },
        ['javascriptreact'] = { { 'prettierd', 'prettier' } },
        ['typescript'] = { { 'prettierd', 'prettier' } },
        ['typescriptreact'] = { { 'prettierd', 'prettier' } },
        ['vue'] = { { 'prettierd', 'prettier' } },
        ['css'] = { { 'prettierd', 'prettier' } },
        ['scss'] = { { 'prettierd', 'prettier' } },
        ['less'] = { { 'prettierd', 'prettier' } },
        ['html'] = { { 'prettierd', 'prettier' } },
        ['json'] = { { 'prettierd', 'prettier' } },
        ['jsonc'] = { { 'prettierd', 'prettier' } },
        ['yaml'] = { { 'prettierd', 'prettier' } },
        ['graphql'] = { { 'prettierd', 'prettier' } },
        ['handlebars'] = { { 'prettierd', 'prettier' } },
      },
    },
  },
}
