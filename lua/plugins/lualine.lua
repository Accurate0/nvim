---@type LazySpec
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'stevearc/overseer.nvim' },
  config = function()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        section_separators = { left = '', right = '' },
        component_separators = '|',
        disabled_filetypes = { 'packer', 'NvimTree', 'alpha', 'neo-tree' },
      },
      sections = {
        lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
        lualine_b = { 'branch' },
        lualine_c = {
          {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
          },
        },
        lualine_x = {
          {
            'overseer',
          },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
          },
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { { 'location', separator = { right = '' } } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'filename',
            file_status = true, -- displays file status (readonly status, modified status)
            path = 1,
          },
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { 'fugitive' },
    }
  end,
}
