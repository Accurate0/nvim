M = {}

function M.get_database()
  local sqlite = require 'sqlite.db'
  local db = sqlite {
    uri = vim.fn.stdpath 'data' .. '/session.db',
    sessions = {
      name = { 'text', unique = true, primary = true, required = true },
      load_count = { 'integer', required = true },
    },
    opts = { keep_open = true },
  }

  return db
end

return M
