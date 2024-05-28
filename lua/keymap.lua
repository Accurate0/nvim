local map = function(mode, key, command, desc)
  vim.keymap.set(mode, key, command, { desc = desc })
end

map('n', '<Esc>', '<cmd>nohlsearch<CR>')
map('t', '<Esc><Esc>', '<C-\\><C-n>', 'Exit terminal mode')

map('n', '<C-h>', '<C-w><C-h>', 'Move focus to the left window')
map('n', '<C-l>', '<C-w><C-l>', 'Move focus to the right window')
map('n', '<C-j>', '<C-w><C-j>', 'Move focus to the lower window')
map('n', '<C-k>', '<C-w><C-k>', 'Move focus to the upper window')

map('', '<Leader>d', '"_d', 'Delete without copying')

map('n', '<leader>L', require('lazy').show, 'Open Lazy')
map('n', '<leader>M', require('mason.ui').open, 'Open Mason')

map('n', '<C-u>', '<C-u>zz')
map('n', '<C-d>', '<C-d>zz')
