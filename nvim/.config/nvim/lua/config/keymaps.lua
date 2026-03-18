local keymap = vim.keymap.set

keymap('n', '<leader>w', '<cmd>w<CR>', { silent = true, desc = "保存文件" })
keymap('n', '<leader>q', '<cmd>q<CR>', { silent = true, desc = "退出" })
keymap('i', 'jk', '<ESC>', { desc = "退出插入模式" })
