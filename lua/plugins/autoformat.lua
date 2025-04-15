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
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
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
