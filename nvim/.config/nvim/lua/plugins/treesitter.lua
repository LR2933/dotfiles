return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false,
    config = function()
      local configs = require("nvim-treesitter.config")

      configs.setup({
          ensure_install_dir = vim.fn.stdpath("data") .. "lazy/nvim-treesitter",
          ensure_installed = { "python", "lua", "vim", "vimdoc","markdown", "markdown_inline" },

          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,--关闭正则高亮
          },

          indent = {
            enable = true
          },
      })

      vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "lazy/nvim-treesitter")
    end,
  },
}
