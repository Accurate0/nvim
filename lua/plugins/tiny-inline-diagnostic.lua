---@type LazySpec
return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  opts = {
    signs = {
      left = ' ',
      right = ' ',
      diag = ' ●',
      arrow = '    ',
      up_arrow = '    ',
      vertical = ' │',
      vertical_end = ' └',
    },
    overflow = { mode = 'wrap' },
    options = {
      multiple_diag_under_cursor = true,
      show_source = true,
      multilines = true,
    },
  },
  config = function(_, opts)
    require('tiny-inline-diagnostic').setup(opts)
  end,
}
