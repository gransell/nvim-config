-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Always go to middle of the screen when movin up or down a page
vim.keymap.set('n', '<C-u>', '<C-u>zz<CR>')
vim.keymap.set('n', '<C-d>', '<C-d>zz<CR>')

-- quit
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Cycle through buffers
vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<cr>', { desc = 'Prev buffer' })
vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<cr>', { desc = 'Next buffer' })
vim.keymap.set('n', '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', { desc = 'Toggle pin' })
vim.keymap.set('n', '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', { desc = 'Delete non-pinned buffers' })
vim.keymap.set('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', { desc = 'Delete other buffers' })

-- Diagnostic keymaps
-- vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
-- vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>nh', '<cmd>noh<cr>', { desc = 'Clear highlights' })

vim.keymap.set('n', '<leader>wsh', '<C-w>s', { desc = 'Split window horizontally' })
vim.keymap.set('n', '<leader>wsv', '<C-w>v', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>wse', '<C-w>=', { desc = 'Make splits equal size' })
vim.keymap.set('n', '<leader>wx', '<cmd>close<cr>', { desc = 'Close window' })

vim.keymap.set('n', '<leader>fw', '<cmd>w<cr><esc>', { desc = '[F]ile [W]rite' })

vim.api.nvim_set_keymap('n', '<leader>sc', '<cmd>lua require("switch_case").switch_case()<CR>', { noremap = true, silent = true })
