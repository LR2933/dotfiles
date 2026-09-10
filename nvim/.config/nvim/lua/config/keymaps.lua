local keymap = vim.keymap.set

keymap('n', '<leader>w', '<cmd>update<CR>', {desc = "保存(仅限更改后)"})

keymap('n', '<leader>q', '<cmd>q<CR>', {desc = "退出" })

keymap('i', 'jk', '<ESC>', { desc = "退出插入模式" })

keymap("n", "<leader>th", ":Telescope colorscheme enable_preview=true<CR>", { desc = "Switch Themes" })

keymap('n', 'gl', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

-- 将 <leader>r 映射为执行 checktime
vim.keymap.set('n', '<leader>r', '<cmd>checktime<cr>', { desc = '检查文件变更' })

-- 在可视模式下粘贴时，将被替换的内容扔进“黑洞寄存器”，保留原有的复制内容
vim.keymap.set("x", "p", [["_dP]])

keymap("n", "<F5>", function()
    vim.cmd("write")

    local ft = vim.bo.filetype
    local file = vim.fn.shellescape(vim.fn.expand("%"))

    if ft == "python" then
        vim.cmd("split | terminal python3 " .. file)
    elseif ft == "sh" then
        vim.cmd("split | terminal bash " .. file)
    end
end)
