return {
  'ptdewey/pendulum-nvim',
  config = function()
    require('pendulum').setup {
      log_file = vim.fn.expand("$HOME/.local/state/pendulum-log.csv")
    }
  end,
}
