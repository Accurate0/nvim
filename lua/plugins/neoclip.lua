---@type LazySpec
return {
  'AckslD/nvim-neoclip.lua',
  event = 'VeryLazy',
  dependencies = {
    { 'kkharji/sqlite.lua' },
    { 'nvim-telescope/telescope.nvim' },
  },
  keys = {
    { '<leader>y', '<cmd>Telescope neoclip<cr>', desc = '[Y]ank history' },
  },
  opts = {
    history = 10000,
    enable_persistent_history = true,
  },
  config = function(_, opts)
    require('neoclip').setup(opts)
  end,
}
