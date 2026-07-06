return {
  -- 1. 核心补全插件：负责在你输入时显示灰色的代码建议
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot", -- 只有运行 :Copilot 命令时才加载
    event = "VeryLazy", -- "InsertEnter"进入插入模式时自动启动
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = false,
          auto_trigger = true, -- 输入时自动触发建议
          keymap = {
            accept = "<M-l>", -- 按 Alt + l (L) 接受建议
          },
        },
      })
    end,
  },
}
