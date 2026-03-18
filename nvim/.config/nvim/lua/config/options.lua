local opt = vim.opt

opt.number = true           -- 显示行号
opt.relativenumber = true   -- 相对行号
opt.mouse = 'a'             -- 允许鼠标控制
opt.termguicolors = true    -- 开启真彩色支持
opt.clipboard = "unnamedplus" -- 使用系统剪贴板

-- 缩进设置
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
