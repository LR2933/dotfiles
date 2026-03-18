return {
  -- 1. Mason 本体
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = { "pyright", "lua-language-server" },
    },
  },

  -- 2. LSP 主配置 (合并 Mason-LSPConfig 的逻辑)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- 第一步：配置 Mason-LSPConfig
      mason_lspconfig.setup({
        ensure_installed = { "pyright", "lua_ls" }, -- 确保安装
        automatic_installation = true,
        
        -- 【关键修复】使用 handlers 自动处理 setup，而不是手动调用
        handlers = {
          -- 1. 默认处理程序：不仅是 Pyright，所有未单独配置的 server 都会走这里
          function(server_name)
            lspconfig[server_name].setup({})
          end,

          -- 2. 针对 Lua 的特殊配置 (覆盖默认)
          ["lua_ls"] = function()
            lspconfig.lua_ls.setup({
              settings = {
                Lua = {
                  diagnostics = {
                    globals = { "vim" },
                  },
                },
              },
            })
          end,
          
          -- 如果未来需要给 Pyright 加特殊配置，可以在这里加 ["pyright"] = function...
        },
      })

      -- 按键映射 (保持你原有的配置)
      local keymap = vim.keymap --为了方便引用
      
      -- 注意：官方推荐使用 LspAttach 事件来绑定按键，这样只在 LSP 启动时才生效
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf, silent = true }
          
          -- 定义跳转和查看的按键
          opts.desc = "Goto Definition"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          
          opts.desc = "Hover"
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          
          -- 可以在这里添加更多，比如重命名 <leader>rn 等
        end,
      })
    end,
  },
}
