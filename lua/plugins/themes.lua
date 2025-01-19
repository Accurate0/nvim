---@type LazySpec
return {
  {
    'mellow-theme/mellow.nvim',
    name = 'mellow',
    priority = 1000,
    lazy = false,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'mellow-theme/mellow.nvim',
    priority = 1000,
    lazy = false,
  },
  {
    'dgox16/oldworld.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'vague2k/vague.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('vague').setup {
        -- optional configuration here
      }
    end,
  },
  { 'fcancelinha/nordern.nvim', branch = 'master', priority = 1000 },
}
