return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
  },
  { 'loctvl842/monokai-pro.nvim', priority = 1000 },
  { 'rose-pine/neovim', name = 'rose-pine' },
  {
    'ribru17/bamboo.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('bamboo').setup {}
      require('bamboo').load()
    end,
  },
}
