---@type LazySpec
return {
  {
    'olimorris/persisted.nvim',
    lazy = false,
    config = function()
      require('persisted').setup {
        allowed_dirs = {
          '~/.config/nvim',
          '~/Projects',
        },
        ignored_dirs = {
          '~/.config',
          '~/.local/nvim',
          { '/', exact = true },
          { '/tmp', exact = true },
        },
        should_autosave = function()
          if vim.bo.filetype == 'alpha' then
            return false
          end
          return true
        end,
      }
    end,
  },
}
