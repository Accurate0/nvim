---@type LazySpec
return {
  {
    'tris203/precognition.nvim',
    opts = {
      startVisible = true,
      showBlankVirtLine = false,
    },
    config = function(_, opts)
      local precognition = require 'precognition'
      precognition.setup(opts)

      -- vim.api.nvim_create_autocmd('CursorHold', {
      --   desc = 'Precognition: show on CursorHold',
      --   callback = function()
      --     precognition.peek()
      --   end,
      -- })
    end,
    event = 'VeryLazy',
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
