---@type LazySpec
return {
  {
    'echasnovski/mini.comment',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    event = 'BufEnter',
    config = function()
      require('mini.comment').setup {
        options = {
          custom_commentstring = function()
            return require('ts_context_commentstring.internal').calculate_commentstring()
              or vim.bo.commentstring
          end,
        },
      }
    end,
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()
      require('mini.move').setup()
    end,
  },
}
