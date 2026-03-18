return {
  "joshuavial/aider.nvim",
  keys = {
    { "<leader>AO", "<cmd>AiderOpen<CR>", desc = "Open Aider" },
    { "<leader>AM", "<cmd>AiderAddModifiedFiles<CR>", desc = "Add modified files to Aider" },
  },
  opts = {
    auto_manage_context = true,
    default_bindings = false,
    debug = false
  },
}
