-- runs after all plugins are installed, so we can setup plugin commands here
vim.keymap.set('n', '<leader>e', '<CMD>Oil<CR>', { desc = 'Open file explorer on file' })
vim.keymap.set('n', '<leader>E', '<CMD>e .<CR>', { desc = 'Open file explorer at current working directory' })
vim.keymap.set('n', '<leader>h', '<CMD>lua MiniPick.builtin.help({default_split = "vertical"})<CR>',
    { desc = 'Open help' })
vim.keymap.set('n', '<leader>f', '<CMD>Pick files<CR>', { desc = 'Pick from files' })
vim.keymap.set('n', '<leader>b', '<CMD>Pick buffers<CR>', { desc = 'Pick from buffers' })
vim.keymap.set('n', '<leader>g', '<CMD>Pick grep_live<CR>', { desc = 'Picker to grep files' })
