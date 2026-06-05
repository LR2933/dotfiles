return {
  "echasnovski/mini.nvim",
  version = false,
  config = function()
    -- 💡 在这里点名激活，没点名的模块完全不会加载，零内存占用！
    require("mini.surround").setup({})

    -- 如果以后想用自动括号补全，直接取消下面这行的注释即可：
    -- require("mini.pairs").setup({})

    -- 如果想用极其顺滑的快速注释：
    -- require("mini.comment").setup({})
  end,
}
