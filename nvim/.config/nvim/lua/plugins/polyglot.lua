return {
    -- vim-polyglot 是一个万能语法包，包含了 100 多种语言的传统高亮
    -- 它不需要 Treesitter，安装即用，非常适合 WSL 环境
    {
        "sheerun/vim-polyglot",
        -- 这里的配置可以确保它不会和你的基础设置冲突
        init = function()
            -- 在插件加载前设置一些全局变量
            vim.g.polyglot_disabled = { "sensible" } -- 禁用一些可能干扰 init.lua 的基础设置
        end,
    }
}
