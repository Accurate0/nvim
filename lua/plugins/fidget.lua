---@type LazySpec
return {
  {
    'j-hui/fidget.nvim',
    opts = {
      notification = {
        override_vim_notify = true,
        window = {
          y_padding = 1,
        },
      },
    },
  },
}
