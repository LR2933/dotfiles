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
