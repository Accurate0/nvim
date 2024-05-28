---@type LazySpec
return {
  {
    'tris203/precognition.nvim',
    opts = {
      startVisible = true,
      showBlankVirtLine = false,
    },
    event = 'BufEnter',
    keys = {
      {
        '<leader>tp',
        function()
          require('precognition').toggle()
        end,
        desc = '[T]oggle [P]recognition',
      },
    },
  },
}
