---@type LazySpec
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    enabled = false,
    main = 'ibl',
    opts = {
      indent = { highlight = { 'Comment' } },
    },
    config = function(_, opts)
      require('ibl').setup(opts)
    end,
  },
}
