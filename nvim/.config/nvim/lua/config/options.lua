local opt = vim.opt

opt.number = true           -- 显示行号
opt.relativenumber = true   -- 相对行号
opt.mouse = ''             -- 不允许鼠标控制
opt.termguicolors = true    -- 开启真彩色支持
opt.clipboard = "unnamedplus" -- 使用系统剪贴板

-- 缩进设置
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4

-- 1. 设置 Neovim 的隐藏级别为 2 
-- 0: 不隐藏；1: 隐藏但保留占位符；2: 隐藏并替换为缩写或符号
opt.conceallevel = 2

-- 2. 配置 VimTeX 隐藏符号的范围
-- a: 上下标, b: 粗体/斜体, d: 定界符(如括号), m: 数学符号, g: 希腊字母
vim.g.tex_conceal = "abdmg"
