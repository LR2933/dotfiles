return {
  -- 1. 核心补全插件：负责在你输入时显示灰色的代码建议
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot", -- 只有运行 :Copilot 命令时才加载
    event = "VeryLazy", -- "InsertEnter"进入插入模式时自动启动
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true, -- 输入时自动触发建议
          keymap = {
            accept = "<M-l>", -- 按 Alt + l (L) 接受建议
          },
        },
      })
    end,
  },

  -- 2. 聊天窗口插件：负责解释代码、重构或修 Bug
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- 必须依赖上面的插件
      { "nvim-lua/plenary.nvim" },  -- 许多 Lua 插件必备的基础库
    },
    opts = {
      language = "zh-cn", -- 强制使用中文回复
      show_help = "no",   -- 关闭帮助提示以保持界面整洁
      system_prompt = [[
        ## User Profile
        - **Role**: Computer Science Student (计算机专业学生)
        - **Environment**: Pop!_OS with COSMIC desktop (Linux user, non-WSL)
        - **Editor/Tools**: Neovim (primary), tmux, Git, Zsh (Oh My Posh)
        - **Hardware**: Lenovo Legion R9000P

        ## Technical Stack & Interests
        - **Languages**: C++, Python, Go, Bash
        - **Fields**: Algorithms (Data Structures, Sliding Window), Robotics (RoboCup 3D Soccer Simulation, Simspark, RoboViz)
        - **Current Projects**: 
          - Preparing for Lanqiao Cup Provincial Competition (Goal: First Prize)
          - RoboCup University Competition (Agent strategy development)
        - **Coding Style**: Prefers optimized, clean code; active on LeetCode.

        ## Interaction Preferences
        - **Language**: Bilingual (Chinese & English).
        - **Goal**: Currently learning English; requires grammar corrections and natural phrasing suggestions.
        - **Tone**: Technical, concise, and grounded.
      ]],
      window = {
        width = 0.3, -- 聊天窗口占屏幕宽度的30%
      },
    },
    keys = {
      -- 快捷键：按下 <leader>cc 打开/关闭聊天窗 (通常 leader 是空格)
      { "<leader>cc", "<cmd>CopilotChatToggle<cr>", desc = "Toggle Copilot Chat", mode = {"n", "v"}},
    },
  },
}

