-- ==============================================================================
-- 基礎設定 (Basic Options)
-- ==============================================================================

-- 顯示絕對行號
vim.opt.number = true
vim.opt.relativenumber = true -- 相對行號 (對移動非常有幫助)

-- 啟用真彩色支援
vim.opt.termguicolors = true

-- 套用主題
vim.cmd("colorscheme matrix")

-- 設置 leader 鍵 (通常建議設為空白鍵)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 縮排設定
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- 搜尋設定
vim.opt.ignorecase = true -- 忽略大小寫
vim.opt.smartcase = true  -- 除非搜尋關鍵字有大寫，否則不忽略

-- ==============================================================================
-- ✍️ 寫作專屬：原生排版與折行優化
-- ==============================================================================

-- 限制正文的最大文本寬度
vim.opt.textwidth = 80

-- 啟用自動折行 (Wrap)
vim.opt.wrap = true

-- 智能折行
vim.opt.linebreak = true

-- 保持光標上下有 8 行的餘量
vim.opt.scrolloff = 8

-- 淡淡地高亮當前游標所在的整行
vim.opt.cursorline = true

-- 其他設定
vim.opt.mouse = "a"               -- 啟用滑鼠
vim.opt.clipboard = "unnamedplus" -- 允許 Neovim 使用系統剪貼簿

-- ==============================================================================
-- 基礎按鍵映射 (Basic Keymaps)
-- ==============================================================================

-- 快速保存 (Space + w) -> 專職保存，不再幹別的！
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- 快速退出 (Space + q)
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- 取消搜尋高亮
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- ==============================================================================
-- 📝 Markdown 寫作自動化 (YAML 插入与字數統計)
-- ==============================================================================

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        
        -- 定义插入 YAML 的函数
        local function insert_writing_yaml()
            local date_str = os.date("%Y-%m-%d %H:%M:%S")
            local yaml = {
                "---",
                "title: ",
                "date: '" .. date_str .. "'",
                "last_modified: '" .. date_str .. "'",
                "collection: ",
                "categories: ",
                "tags: [  ]",
                "chars: [  ]",
                "geos: [  ]",
                "description: ",
                "words: 0",
                "---",
                ""
            }
            
            -- 【彻底修复】不再管光标在哪。0 代表从文件的最顶端（第 0 行下方，即第 1 行）强制写入！
            vim.fn.append(0, yaml)

            -- 强行把光标拉回到第 2 行（title: 所在的行）的第 7 个字符
            vim.api.nvim_win_set_cursor(0, { 2, 7 })
            
            -- 自动进入编辑模式
            vim.cmd("startinsert!")
        end

        -- 【已修改】将快捷键换成 <leader>y (Space + y)，代表插入 YAML
        -- 这样就和 Space + w (保存) 彻底分家，互不干扰！
        vim.keymap.set("n", "<leader>y", insert_writing_yaml, { buffer = true, desc = "插入每日写作 YAML" })
        -- 2. 【核心新功能】在编辑模式下，连续按下两次分号，一键段首缩进
        vim.keymap.set("i", ";;", "　　", { buffer = true, desc = "插入段首两个全角空格" })
    end
})

-- 保存时自动更新 last_modified 时间和 words 字数
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.md",
    callback = function()
        local all_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        
        -- 安全检查：如果文档里连第二个 --- 都没有（比如完全是个空文档），直接退出，不搞小动作
        local yaml_delim_count = 0
        for _, line in ipairs(all_lines) do
            if line:match("^---$") then
                yaml_delim_count = yaml_delim_count + 1
            end
        end
        if yaml_delim_count < 2 then return end

        -- A. 更新最后修改时间
        local current_time = os.date("%Y-%m-%d %H:%M:%S")
        local lines = vim.api.nvim_buf_get_lines(0, 0, 20, false)
        
        for idx, line in ipairs(lines) do
            if line:match("^last_modified:") then
                local new_line = "last_modified: '" .. current_time .. "'"
                vim.api.nvim_buf_set_lines(0, idx - 1, idx, false, { new_line })
                break
            end
        end

        -- B. 统计字数
        local content_start_idx = 1
        local current_delim_count = 0

        for idx, line in ipairs(all_lines) do
            if line:match("^---$") then
                current_delim_count = current_delim_count + 1
                if current_delim_count == 2 then
                    content_start_idx = idx + 1
                    break
                end
            end
        end

        local word_count = 0
        for i = content_start_idx, #all_lines do
            local text = all_lines[i]
            if text and text ~= "" then
                text = text:gsub("[%s%t%n%r]", "")
                text = text:gsub("\xe3\x80\x80", "")
                if text ~= "" then
                    word_count = word_count + vim.fn.strchars(text)
                end
            end
        end

        -- C. 将统计出的字数回写
        for idx, line in ipairs(lines) do
            if line:match("^words:") then
                local new_line = "words: " .. word_count
                vim.api.nvim_buf_set_lines(0, idx - 1, idx, false, { new_line })
                break
            end
        end
    end
})