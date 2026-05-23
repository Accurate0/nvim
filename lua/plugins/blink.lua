---@type LazySpec
return {
  'saghen/blink.cmp',
  event = 'InsertEnter',
  dependencies = {
    'saghen/blink.lib',
    'rafamadriz/friendly-snippets',
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
  },
  build = function()
    require('blink.cmp').build():wait(60000)
  end,

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      ['<Tab>'] = { 'select_next', 'fallback' },
      ['<S-Tab>'] = { 'select_prev', 'fallback' },
      ['<C-e>'] = { 'cancel', 'fallback' },
      ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
      ['<C-f>'] = { 'scroll_documentation_up', 'fallback' },
      ['<CR>'] = { 'accept', 'fallback' },
      ['<C-Space>'] = { 'show', 'fallback' },
      ['<C-l>'] = {
        function(_cmp)
          local luasnip = require 'luasnip'
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
            return true
          end
        end,
        'fallback',
      },
      ['<C-h>'] = {
        function(cmp)
          local luasnip = require 'luasnip'
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
            return true
          end
        end,
        'fallback',
      },
    },
    snippets = { preset = 'luasnip' },
    completion = {
      documentation = {
        auto_show = true,
        window = { border = 'rounded' },
      },
      menu = {
        draw = {
          columns = {
            { 'kind_icon' },
            { 'label', 'label_description', gap = 1 },
            { 'source_name' },
          },
        },
      },
      ghost_text = { enabled = false },
      list = { selection = { preselect = true, auto_insert = false } },
    },
    signature = { enabled = true },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },
    fuzzy = { implementation = 'rust' },
  },
}
