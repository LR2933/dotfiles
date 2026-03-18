return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- 用于显示图标
    "MunifTanjim/nui.nvim",
  },
  keys = {
    -- 快捷键：使用 <leader>e 打开文件树
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree (Root Dir)" },
  },
  config = function()
    require("neo-tree").setup({
      -- 1. 窗口设置
      window = {
        width = 30,
        mappings = {
          ["<space>"] = "none", -- 禁用空格，防止干扰 leader 键
          ["l"] = "open",       -- 习惯性用 l 打开
          ["h"] = "close_node", -- 用 h 折叠
        },
      },
      -- 2. 文件系统设置
      filesystem = {
        filtered_items = {
          visible = true, -- 是否显示被忽略的文件
          hide_dotfiles = false, -- 显示隐藏文件（以点开头的文件）
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true, -- 当你切换编辑的文件时，文件树会自动定位到该文件
        },
        use_libuv_file_watcher = true, -- 实时监控文件变化
      },
      -- 3. 渲染美化
      default_component_configs = {
        indent = {
          with_expanders = true, -- 显示可折叠的加减号
          expander_collapsed = "",
          expander_expanded = "",
        },
        git_status = {
          symbols = {
            -- 修改 Git 状态图标，使其更美观
            added     = "✚",
            modified  = "",
            deleted   = "✖",
            renamed   = "󰁯",
            untracked = "",
            ignored   = "",
            unstaged  = "󰄱",
            staged    = "",
            conflict  = "",
          },
        },
      },
    })
  end,
}
