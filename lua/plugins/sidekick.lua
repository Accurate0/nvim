---@type LazySpec
return {
  {
    'folke/sidekick.nvim',
    event = 'VeryLazy',
    opts = {
      nes = { enabled = false },
      cli = {
        mux = {
          backend = 'tmux',
          enabled = true,
        },
        win = {
          wo = {
            winbar = '',
            winhighlight = 'Normal:NormalFloat,NormalNC:NormalFloat,EndOfBuffer:NormalFloat,SignColumn:NormalFloat,WinBar:DiagnosticInfo,WinBarNC:DiagnosticHint,FoldColumn:NormalFloat',
            foldcolumn = '2',
          },
          split = {
            width = 80,
          },
        },
      },
    },
    keys = {
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<c-/>',
        function()
          require('sidekick.cli').focus()
        end,
        mode = { 'n', 'i', 'v', 't' },
        desc = 'Sidekick Switch Focus',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select()
        end,
        desc = 'Select CLI',
      },
      {
        '<leader>ad',
        function()
          require('sidekick.cli').close()
        end,
        desc = 'Detach a CLI Session',
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').send { msg = '{this}' }
        end,
        mode = { 'x', 'n' },
        desc = 'Send This',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send { msg = '{selection}' }
        end,
        mode = { 'x' },
        desc = 'Send Visual Selection',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
      {
        '<c-.>',
        function()
          require('sidekick.cli').focus()
        end,
        mode = { 'n', 'x', 'i', 't' },
        desc = 'Sidekick Switch Focus',
      },
    },
  },
}
