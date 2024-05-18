local map = function(mode, key, command, desc)
  vim.keymap.set(mode, key, command, { desc = desc })
end

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

map('n', '<leader>e', vim.diagnostic.open_float, 'Show diagnostic [E]rror messages')
map('t', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')

map('n', '<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map('n', '<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map('n', '<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map('n', '<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

map('n', '<leader>L', require('lazy').show, 'Open Lazy')
map('n', '<leader>M', require('mason.ui').open, 'Open Mason')

map('n', '<leader>w', function()
  require('neo-tree.command').execute { toggle = true }
end, 'Toggle neotree')

map('n', '<leader>tp', require('precognition').toggle, '[T]oggle [P]recognition')

map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')

map('n', '<A-1>', '<Cmd>BufferPrevious<CR>', 'Previous Tab')
map('n', '<A-2>', '<Cmd>BufferNext<CR>', 'Next Tab')
map('n', '<A-w>', '<Cmd>BufferClose<CR>', 'Close Tab')
