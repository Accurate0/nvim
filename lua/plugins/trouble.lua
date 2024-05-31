---@type LazySpec
return {
  {
    'folke/trouble.nvim',
    keys = {
      {
        '<leader>q',
        '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>',
        desc = 'Diagnostics (Trouble)',
      },
    },
    opts = {},
  },
}
