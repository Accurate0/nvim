vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>L', require('lazy').show, { desc = 'Open Lazy' })
vim.keymap.set('n', '<leader>M', require('mason.ui').open, { desc = 'Open Mason' })

vim.keymap.set('n', '<leader>w', function()
  require('neo-tree.command').execute { toggle = true }
end, { desc = 'Toggle neotree' })

vim.keymap.set('n', '<A-1>', '<Cmd>BufferPrevious<CR>', { desc = 'Previous Tab' })
vim.keymap.set('n', '<A-2>', '<Cmd>BufferNext<CR>', { desc = 'Next Tab' })
vim.keymap.set('n', '<A-w>', '<Cmd>BufferClose<CR>', { desc = 'Close Tab' })

vim.keymap.set('n', '<leader>tp', require('precognition').toggle, { desc = '[T]oggle [P]recognition' })

-- FIXME: graphical glitch because kitty render too fast...
-- vim.keymap.set('n', '<C-u>', '<C-u>zz')
-- vim.keymap.set('n', '<C-d>', '<C-d>zz')
