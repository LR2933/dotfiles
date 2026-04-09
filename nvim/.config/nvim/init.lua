vim.g.mapleader = " " -- 空格作为 Leader 键


-- 1. 加载基础设置
require("config.options")
-- 2. 加载基础快捷键
require("config.keymaps")


--- 1. 自动安装 lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 最新稳定版
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. 初始化 lazy.nvim 并添加插件
require("lazy").setup("plugins")

--开启真彩色支持
vim.opt.termguicolors = true

--新的垂直分屏将默认在当前窗口的右侧
vim.opt.splitright = true

--禁用回环
vim.g.tmux_navigator_no_wrap = 1

-- 设置主题
vim.cmd.colorscheme("catppuccin") -- catppuccin

-- 在可视模式下粘贴时，将被替换的内容扔进“黑洞寄存器”，保留原有的复制内容
vim.keymap.set("x", "p", [["_dP]])

