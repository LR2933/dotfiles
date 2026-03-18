return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local configs = require("nvim-treesitter.config")
      
      configs.setup({
          ensure_installed = { "python", "lua", "vim", "vimdoc" },

          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,--关闭正则高亮
          },

          indent = {
            enable = true   
          },
      })
    end,
  },
}
