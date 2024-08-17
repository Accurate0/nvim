---@type LazySpec
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
    event = 'BufEnter',
    keys = {
      {
        '<A-1>',
        '<Cmd>BufferPrevious<CR>',
        desc = 'Previous Tab',
      },
      {
        '<A-2>',
        '<Cmd>BufferNext<CR>',
        desc = 'Next Tab',
      },
      {
        '<A-w>',
        '<Cmd>BufferClose<CR>',
        desc = 'Close Tab',
      },
    },
  },
}
