---@type LazySpec
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        -- Type definitions for plugins referenced in your config
        { path = 'lazy.nvim', words = { 'LazySpec' } },
        { path = 'snacks.nvim', words = { 'Snacks', 'snacks' } },
      },
    },
  },
}
