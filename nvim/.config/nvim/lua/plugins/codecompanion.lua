return{
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      
      gemini = function ()
        return require("codecompanion.adapters").extend("gemini",{
            env = {
              api_key = "GEMINI_API_KEY"
            },
          })
      end,
    },
    
    strategies = {
      chat = { adapter = "gemini" },
      inline = { adapter = "gemini" }
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG",
    },
  },
}
