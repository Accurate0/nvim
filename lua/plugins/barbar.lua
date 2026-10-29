local key = function(k)
  return vim.fn.has 'mac' == 1 and '<leader>' .. k or '<A-' .. k .. '>'
end

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
        key '1',
        '<Cmd>BufferPrevious<CR>',
        desc = 'Previous Tab',
      },
      {
        key '2',
        '<Cmd>BufferNext<CR>',
        desc = 'Next Tab',
      },
      {
        key 'w',
        '<Cmd>BufferClose<CR>',
        desc = 'Close Tab',
      },
    },
  },
}
