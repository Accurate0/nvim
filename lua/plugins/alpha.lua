---@type LazySpec
return {
  {
    'goolord/alpha-nvim',
    dependencies = {
      'kkharji/sqlite.lua',
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'olimorris/persisted.nvim',
    },
    config = function()
      local dashboard = require 'alpha.themes.dashboard'
      local cdir = vim.fn.getcwd()
      local if_nil = vim.F.if_nil
      local chars = require('chars').glyphs

      local nvim_web_devicons = {
        enabled = true,
        highlight = true,
      }

      local function splice(tbl, start, length)
        length = length or 1
        start = start or 1
        local endd = start + length
        local spliced = {}
        local remainder = {}
        for i, elt in ipairs(tbl) do
          if i < start or i >= endd then
            table.insert(spliced, elt)
          else
            table.insert(remainder, elt)
          end
        end
        return spliced, remainder
      end

      local function get_session_list()
        local group = { type = 'group', opts = { spacing = 0 }, val = {} }
        local persisted = require 'persisted'
        local sessions = persisted.list()
        local db = require('session').get_database()
        local session_counts_result = db:eval 'SELECT * FROM sessions'
        local session_counts_db = type(session_counts_result) == "boolean" and {} or session_counts_result
        local session_counts = {}
        for _, value in pairs(session_counts_db) do
          session_counts[value.name] = value.load_count
        end

        table.sort(sessions, function(s1, s2)
          local s1_count = pcall(function()
            return session_counts[s1.name]
          end)

          local s2_count = pcall(function()
            return session_counts[s2.name]
          end)

          if s1_count and s2_count then
            return (session_counts[s1.name] or 0) > (session_counts[s2.name] or 0)
          end

          if not s2_count then
            return true
          end

          if not s1_count then
            return false
          end

          return false
        end)

        local _, remainder = splice(sessions, 1, 8)

        for i, session in pairs(remainder) do
          local initial_char = chars[math.random(#chars)]
          local button_text = initial_char .. '  ' .. session.name
          local button = dashboard.button(
            string.char(96 + i),
            button_text,
            '<cmd>SessionLoadFromFile ' .. session.file_path .. '<cr>'
          )

          local last_part = button_text:match '.*[/\\]'

          button.opts.hl = { { 'Comment', 2, #last_part } }
          table.insert(group.val, button)
        end

        return group
      end

      local function get_extension(fn)
        local match = fn:match '^.+(%..+)$'
        local ext = ''
        if match ~= nil then
          ext = match:sub(2)
        end
        return ext
      end

      local function icon(fn)
        local nwd = require 'nvim-web-devicons'
        local ext = get_extension(fn)
        return nwd.get_icon(fn, ext, { default = true })
      end

      local function file_button(fn, sc, short_fn, autocd)
        short_fn = short_fn or fn
        local ico_txt
        local fb_hl = {}

        if nvim_web_devicons.enabled then
          local ico, hl = icon(fn)
          local hl_option_type = type(nvim_web_devicons.highlight)
          if hl_option_type == 'boolean' then
            if hl and nvim_web_devicons.highlight then
              table.insert(fb_hl, { hl, 0, 3 })
            end
          end
          if hl_option_type == 'string' then
            table.insert(fb_hl, { nvim_web_devicons.highlight, 0, 3 })
          end
          ico_txt = ico .. '  '
        else
          ico_txt = ''
        end
        local cd_cmd = (autocd and ' | cd %:p:h' or '')
        local file_button_el =
            dashboard.button(sc, ico_txt .. short_fn, '<cmd>e ' .. fn .. cd_cmd .. ' <CR>')
        local fn_start = short_fn:match '.*[/\\]'
        if fn_start ~= nil then
          table.insert(fb_hl, { 'Comment', #ico_txt - 2, #fn_start + #ico_txt })
        end
        file_button_el.opts.hl = fb_hl
        return file_button_el
      end

      local default_mru_ignore = { 'gitcommit' }

      local mru_opts = {
        ignore = function(path, ext)
          return (string.find(path, 'COMMIT_EDITMSG'))
              or (vim.tbl_contains(default_mru_ignore, ext))
        end,
        autocd = false,
      }

      --- @param start number
      --- @param cwd string? optional
      --- @param items_number number? optional number of items to generate, default = 10
      local function mru(start, cwd, items_number, opts)
        opts = opts or mru_opts
        items_number = if_nil(items_number, 10)

        local oldfiles = {}
        for _, v in pairs(vim.v.oldfiles) do
          if #oldfiles == items_number then
            break
          end
          local cwd_cond
          if not cwd then
            cwd_cond = true
          else
            cwd_cond = vim.startswith(v, cwd)
          end
          local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
          if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
            oldfiles[#oldfiles + 1] = v
          end
        end
        local target_width = 35

        local tbl = {}
        for i, fn in ipairs(oldfiles) do
          local short_fn
          if cwd then
            short_fn = vim.fn.fnamemodify(fn, ':.')
          else
            short_fn = vim.fn.fnamemodify(fn, ':~')
          end

          if #short_fn > target_width then
            ---@diagnostic disable-next-line: param-type-mismatch
            short_fn = require('plenary.path').new(short_fn):shorten(1, { -2, -1 })
            if #short_fn > target_width then
              short_fn = require('plenary.path').new(short_fn):shorten(1, { -1 })
            end
          end

          local shortcut = tostring(i + start - 1)

          local file_button_el = file_button(fn, shortcut, short_fn, opts.autocd)
          tbl[i] = file_button_el
        end
        return {
          type = 'group',
          val = tbl,
          opts = {},
        }
      end

      local fortune = vim.fn.system { 'fortune', '-a', '-s', '-n', '50' }
      local split_fortune = {}
      for line in fortune:gmatch '[^\n]+' do
        table.insert(split_fortune, line)
      end

      local header = {
        type = 'text',
        val = split_fortune,
        opts = {
          position = 'center',
        },
      }

      local section_mru = {
        type = 'group',
        val = {
          {
            type = 'text',
            val = 'Recent files',
            opts = {
              hl = 'Title',
              shrink_margin = false,
              position = 'center',
            },
          },
          { type = 'padding', val = 1 },
          {
            type = 'group',
            val = function()
              return { mru(0, cdir) }
            end,
            opts = { shrink_margin = false },
          },
          { type = 'padding', val = 1 },
          {
            type = 'text',
            val = 'Frequent sessions',
            opts = {
              hl = 'Title',
              position = 'center',
            },
          },
          {
            type = 'group',
            val = function()
              return { get_session_list() }
            end,
          },
        },
      }

      local config = {
        layout = {
          { type = 'padding', val = 2 },
          header,
          { type = 'padding', val = 2 },
          section_mru,
        },
        opts = {
          margin = 5,
          setup = function()
            vim.api.nvim_create_autocmd('DirChanged', {
              pattern = '*',
              callback = function()
                require('alpha').redraw()
              end,
            })
          end,
        },
      }

      require('alpha').setup(config)
    end,
  },
}
