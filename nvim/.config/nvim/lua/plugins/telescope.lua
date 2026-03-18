return {
  'nvim-telescope/telescope.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require('telescope.builtin')
    
    -- 1. 查找文件 (Find Files)
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "查找文件" })
    
    -- 2. 全局搜索 (Live Grep) - 需要系统中安装了 ripgrep
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "全局搜索" })
    
    -- 3. 查看当前打开的缓冲区 (Buffers) - 极其好用的文件切换方式
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = "查找已打开文件" })
    
    -- 4. 查看最近打开过的文件 (Recent Files)
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = "查找最近文件" })
  end
}
