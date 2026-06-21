return {
  "https://codeberg.org/andyg/leap.nvim",
  enabled = true,
  -- 💡 遵循官方警告：关闭 lazy.nvim 的 keys 拦截，让插件自己打理加载
  lazy = false, 
  dependencies = {
    "tpope/vim-repeat",
  },
  config = function()
    -- 1. 核心修正：使用官方新版的 <Plug>(leap) 正确对接 f 键！
    -- 这里我们用 f 代替 s，用 F 代替 S（带 backward = true 参数）
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', '<Plug>(leap)')
    
    -- 如果你想用 F 往回跳，需要给 leap 传参：
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', function()
      require('leap').leap { backward = true }
    end)

    -- 2. 注入官方“强烈推荐”的视觉降噪过滤器（Highly Recommended）
    -- 它可以防止在 Scheme 单词中间乱闪高亮，眼睛极其舒适！
    require('leap').opts.preview = function(ch0, ch1, ch2)
      return not (
        ch1:match('%s')
        or (ch0:match('%a') and ch1:match('%a') and ch2:match('%a'))
      )
    end

    -- 3. 注入官方回车/退格“无限连跳”神级连招
    -- 按一下 f 找到目标后，之后只需要疯狂按回车 <cr> 就能一直跳到下一个匹配点
    local clever = require('leap.user').with_traversal_keys
    vim.keymap.set({ 'n', 'x', 'o' }, '<cr>', function()
      require('leap').leap {
        ['repeat'] = true, opts = clever('<cr>', '<bs>'),
      }
    end)
    vim.keymap.set({ 'n', 'x', 'o' }, '<bs>', function()
      require('leap').leap {
        ['repeat'] = true, opts = clever('<bs>', '<cr>'), backward = true,
      }
    end)
  end,
}
