-- runs after all plugins are installed, so we can setup plugin commands here
vim.keymap.set('n', '<leader>e', '<CMD>e .<CR>', { desc = 'Open file explorer' })
vim.keymap.set('n', '<leader>h', '<CMD>lua MiniPick.builtin.help({default_split = "vertical"})<CR>',
    { desc = 'Open help' })
vim.keymap.set('n', '<leader>f', '<CMD>Pick files<CR>', { desc = 'Pick from files' })
vim.keymap.set('n', '<leader>b', '<CMD>Pick buffers<CR>', { desc = 'Pick from buffers' })
