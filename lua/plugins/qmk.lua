---@type LazySpec
return {
  'codethread/qmk.nvim',
  config = function()
    ---@type qmk.UserConfig
    local conf = {
      name = 'LAYOUT_65_ansi_blocker',
      layout = {
        'x x x x x x x x x x x x x ^x^xx x',
        '^xx x x x x x x x x x x x x ^xx x',
        '^xx x x x x x x x x x x x ^xx^x x',
        '^xx^x x x x x x x x x x x x^x x x',
        'x x x x^xxxxxx^xxxxxx x x _ x x x',
      },
    }
    require('qmk').setup(conf)
  end,
}
