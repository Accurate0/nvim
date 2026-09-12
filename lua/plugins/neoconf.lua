---@type LazySpec
return {
  {
    'folke/neoconf.nvim',
    lazy = false,
    priority = 100,
    ---@module 'neoconf'
    ---@type neoconf.Config
    opts = {},
  },
}
