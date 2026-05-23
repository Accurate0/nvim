---@type LazySpec
return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    init = function()
      vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = 'catppuccin*',
        callback = function()
          vim.api.nvim_set_hl(0, 'TelescopeSelection', { bg = '#313244', bold = true })
        end,
      })
    end,
  },
}
