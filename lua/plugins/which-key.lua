---@type LazySpec
return {
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup()
      require('which-key').add {
        { '<leader>c', name = '[C]ode' },
        { '<leader>c_', hidden = true },

        { '<leader>r', name = '[R]ename' },
        { '<leader>r_', hidden = true },

        { '<leader>s', name = '[S]earch' },
        { '<leader>s_', hidden = true },

        { '<leader>t', name = '[T]oggle' },
        { '<leader>t_', hidden = true },

        { '<leader>h', name = 'Git [H]unk' },
        { '<leader>h_', hidden = true },

        { '<leader>o', name = '[O]verseer' },
        { '<leader>o_', hidden = true },

        { '<leader>ob', name = '[O]verseer [B]undle' },
        { '<leader>ob_', hidden = true },
      }
    end,
  },
}
