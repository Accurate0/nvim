---@type LazySpec
return {
  {
    'm4xshen/smartcolumn.nvim',
    event = 'InsertEnter',
    opts = {
      colorcolumn = { '100' },
      disabled_filetypes = {
        'NvimTree',
        'lazy',
        'mason',
        'help',
        'checkhealth',
        'lspinfo',
        'noice',
        'Trouble',
        'fish',
        'zsh',
        'alpha',
      },
    },
  },
}
