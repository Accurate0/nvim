vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { 'catppuccin-mocha' },
  },
})

require 'options'
require 'keymap'
require 'autocmd'
-- fuck my life
vim.cmd.colorscheme 'catppuccin-mocha'

-- vim: ts=2 sts=2 sw=2 et
