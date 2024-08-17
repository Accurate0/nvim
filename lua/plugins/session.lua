---@type LazySpec
return {
  {
    'olimorris/persisted.nvim',
    dependencies = { 'kkharji/sqlite.lua' },
    commit = '0a9eebf5cc92b1113a382a660ee73f21ffd62ae7',
    config = function()
      require('persisted').setup {
        allowed_dirs = {
          '~/.config/nvim',
          '~/Projects',
        },
        ignored_dirs = {
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

      local group = vim.api.nvim_create_augroup('PersistedHooks', {})
      vim.api.nvim_create_autocmd({ 'User' }, {
        pattern = 'PersistedLoadPre',
        group = group,
        callback = function(session)
          local db = require('session').get_database()
          db:eval(
            'INSERT INTO sessions (name, load_count) VALUES (?, 1) ON CONFLICT (name) DO UPDATE SET load_count = sessions.load_count + 1',
            session.data.name
          )
        end,
      })
    end,
  },
}
