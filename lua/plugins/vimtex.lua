return {
  {
    'lervag/vimtex',
    event = 'VeryLazy',
    init = function()
      vim.g.vimtex_quickfix_enabled = false
    end,
  },
}
