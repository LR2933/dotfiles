return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000, -- 确保主题在其他插件之前加载
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- 选填: latte, frappe, macchiato, mocha (默认)
        transparent_background = false, -- 如果想要透明背景可以改为 true
        term_colors = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = "",
          },
          -- 根据你使用的插件开启更多集成
        },
      })

      -- 设置为当前主题
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
