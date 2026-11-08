local keymap = vim.keymap.set

keymap('n', '<leader>w', '<cmd>update<CR>', {desc = "保存(仅限更改后)"})

keymap('n', '<leader>q', '<cmd>q<CR>', {desc = "退出" })

keymap('i', 'jk', '<ESC>', { desc = "退出插入模式" })

keymap("n", "<leader>th", ":Telescope colorscheme enable_preview=true<CR>", { desc = "Switch Themes" })

keymap('n', 'gl', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

-- 将 <leader>r 映射为执行 checktime
vim.keymap.set('n', '<leader>r', '<cmd>checktime<cr>', { desc = '检查文件变更' })

-- 在可视模式下粘贴时，将被替换的内容扔进“黑洞寄存器”，保留原有的复制内容
vim.keymap.set("x", "p", [["_dP]])

keymap("n", "<F5>", function()
    vim.cmd("write")

    local ft = vim.bo.filetype
    local file = vim.fn.shellescape(vim.fn.expand("%"))

    if ft == "python" then
        vim.cmd("vsplit | terminal python3 " .. file)
    elseif ft == "sh" then
        vim.cmd("vsplit | terminal bash " .. file)
    end
end)

-- ===== F8: 切换当前 buffer 的渲染 =====
-- markdown / Avante: 切换 render-markdown 的原地渲染
-- tex: 切换 vimtex 的符号隐藏 (conceal)
local render_augroup = vim.api.nvim_create_augroup("RenderToggle", { clear = true })

-- .tex buffer 进入窗口时恢复自己的 conceal 状态，未切换过则默认渲染
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = render_augroup,
    callback = function(args)
        if vim.bo[args.buf].filetype == "tex" then
            vim.wo.conceallevel = vim.b[args.buf].render_conceal_disabled and 0 or 2
        end
    end,
})

keymap("n", "<F8>", function()
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.bo[buf].filetype
    local function notify(msg, level)
        vim.notify("[Render] " .. msg, level or vim.log.levels.INFO)
    end

    if ft == "markdown" or ft == "Avante" then
        local manager = require("render-markdown.core.manager")
        if not manager.attached(buf) then
            notify("当前 buffer 未启用渲染（文件过大或类型不在 file_types 中）", vim.log.levels.WARN)
            return
        end
        require("render-markdown").buf_toggle()
        local enabled = require("render-markdown.state").get(buf).enabled
        notify("Markdown 渲染: " .. (enabled and "开" or "关"))
    elseif ft == "tex" then
        local disabled = not vim.b[buf].render_conceal_disabled
        vim.b[buf].render_conceal_disabled = disabled
        vim.wo.conceallevel = disabled and 0 or 2
        notify("LaTeX 渲染: " .. (disabled and "关" or "开"))
    else
        notify("当前文件类型不支持渲染开关: " .. (ft ~= "" and ft or "unknown"), vim.log.levels.WARN)
    end
end, { desc = "切换渲染 (Markdown/LaTeX)" })
