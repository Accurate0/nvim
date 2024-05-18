return {
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = false
    end,
    opts = {
      auto_hide = true,
      clickable = false,
      animation = false,
      exclude_ft = { 'qf' },
    },
    version = '^1.0.0',
  },
}
