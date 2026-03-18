return{
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      -- 对 python 文件执行 ruff 格式化
      python = { "ruff_format", "ruff_organize_imports" },
    },
  },
  --手动格式化
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format({ 
          lsp_fallback = true,
          timeout_ms = 500 
        })
      end,
      mode = { "n", "v" }, -- 支持普通模式和可视模式（格式化选中部分）
      desc = "手动执行 PEP 8 格式化",
    },
  },
}
