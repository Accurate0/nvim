---@type LazySpec
return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    lazy = true,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      '3rd/image.nvim',
    },
    keys = {
      {
        '<leader>e',
        function()
          require('neo-tree.command').execute { action = 'show', toggle = true, reveal = true }
        end,
        desc = 'Toggle Neotree',
      },
    },
    config = function()
      require('neo-tree').setup {
        default_component_configs = {
          git_status = {
            symbols = {
              added = '✚',
              deleted = '✖',
              modified = '',
              renamed = '󰁕',
              untracked = '?',
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
            align = 'right',
          },
          icon = {
            folder_closed = ' ',
            folder_open = ' ',
            folder_empty = '󰜌',
          },
        },
        filesystem = {
          use_libuv_file_watcher = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              '.git',
              'build',
              'target',
            },
          },
        },
      }
    end,
  },
}
