return {
  'stevearc/oil.nvim',
  opts = {},
  -- 只有当你需要自定义配置时才写在 config 里，否则上面的 opts = {} 就会启用默认设置
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- 可选：用于显示文件图标
  config = function()
    require("oil").setup({
      -- 这里可以进行个性化配置
      default_file_explorer = true, -- 替代自带的 netrw
      columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
      },
      view_options = {
        show_hidden = true, -- 默认显示隐藏文件（如 .gitignore）
      },
    })

    -- 设置快捷键：按下 - 打开 Oil
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "打开父目录 (Oil)" })
  end
}
