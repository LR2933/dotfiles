return{
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      indent = { char = "│" }, -- 也可以用 "┆", "┊", ""
      scope = { enabled = false }, -- 是否高亮当前代码块的范围
    },
  }
}
