local keymap = vim.keymap.set

keymap('n', '<leader>w', '<cmd>update<CR>', {desc = "保存(仅限更改后)"})

keymap('n', '<leader>q', '<cmd>q<CR>', {desc = "退出" })

keymap('i', 'jk', '<ESC>', { desc = "退出插入模式" })

vim.keymap.set("n", "<leader>th", ":Telescope colorscheme enable_preview=true<CR>", { desc = "Switch Themes" })
