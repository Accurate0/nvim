---@type LazySpec
return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    init = function()
      local ensureInstalled = {
        'bash',
        'c',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
        'rust',
      }

      local alreadyInstalled = require('nvim-treesitter.config').get_installed()
      local parsersToInstall = vim.iter(ensureInstalled)
        :filter(function(parser)
          return not vim.tbl_contains(alreadyInstalled, parser)
        end)
        :totable()

      if #parsersToInstall > 0 then
        require('nvim-treesitter').install(parsersToInstall)
      end

      vim.api.nvim_create_autocmd('FileType', {
        callback = function()
          pcall(vim.treesitter.start)
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })

      vim.filetype.add {
        pattern = { ['.*/hypr/.*%.conf'] = 'hyprlang' },
      }
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    branch = 'main',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-treesitter-textobjects').setup {
        move = {
          enable = true,
          goto_next_start = { [']f'] = '@function.outer' },
          goto_next_end = { [']F'] = '@function.outer' },
          goto_previous_start = { ['[f'] = '@function.outer' },
          goto_previous_end = { ['[F'] = '@function.outer' },
        },
      }
    end,
  },
}
