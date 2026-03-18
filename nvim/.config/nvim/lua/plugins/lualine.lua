return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        theme = 'auto', -- 自动根据你当前的代码配色方案切换主题
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
      },
    })
  end
}
