return {
  {
    'zbirenbaum/copilot.lua',
    event = 'InsertEnter',
    enabled = false,
    opts = {
      {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
  },
  {
    'zbirenbaum/copilot-cmp',
    enabled = false,
    config = function()
      require('copilot_cmp').setup()
    end,
  },
}
