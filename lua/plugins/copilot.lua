---@type LazySpec
return {
  {
    'zbirenbaum/copilot.lua',
    enabled = false,
    event = 'InsertEnter',
    opts = {
      {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
    dependencies = {
      'j-hui/fidget.nvim',
    },
    keys = {
      {
        '<leader>tc',
        '<cmd>Copilot toggle<CR>',
        desc = '[T]oggle [C]opilot',
      },
    },
    config = function(_, opts)
      require('copilot').setup(opts)
      local f = require 'fidget'

      require('copilot.api').register_status_notification_handler(function(data)
        if vim.fn.mode() == 'i' and data.status == 'InProgress' then
          f.notify(' Thinking...', 2, {})
        end

        if data.status == 'Warning' then
          f.notify(' ' .. data.message, 3, {})
        end
      end)
    end,
  },
  {
    'zbirenbaum/copilot-cmp',
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
