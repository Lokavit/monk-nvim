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




-- -- 設置 leader 鍵 (通常建議設為空白鍵)
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

 
-- -- 縮排設定
-- vim.opt.tabstop = 4
-- vim.opt.shiftwidth = 4
-- vim.opt.expandtab = true
-- vim.opt.smartindent = true

-- -- 搜尋設定
-- vim.opt.ignorecase = true -- 忽略大小寫
-- vim.opt.smartcase = true  -- 除非搜尋關鍵字有大寫，否則不忽略

-- -- 其他設定
-- vim.opt.mouse = "a"       -- 啟用滑鼠 (新手友善)
-- vim.opt.clipboard = "unnamedplus" -- 允許 Neovim 使用系統剪貼簿

-- -- ==============================================================================
-- -- 基礎按鍵映射 (Basic Keymaps)
-- -- ==============================================================================

-- -- vim.keymap.set(模式, 按鍵, 命令, 選項)
-- -- "n": 表示此映射僅在 Normal 模式 (普通模式) 下有效。
-- -- "<leader>w": 觸發按鍵。<leader> 鍵在前面已經設定為 空格鍵 (Space)。所以這條指令的意思是：-- 按下 空格鍵 再按 w。
-- -- ":w<CR>": 這就是要執行的 Vim 命令。
-- -- : 是進入命令列模式。
-- -- w 是儲存 (write)。
-- -- <CR> 是回車 (Carriage Return)，代表按下 Enter。
-- -- { desc = "..." }: 描述此功能，在某些插件（如 which-key）中會顯示提示。

-- -- 快速保存 (Leader + w) 按下 Space + w = 儲存檔案。
-- vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })

-- -- 快速退出 (Leader + q)
-- vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })

-- -- 取消搜尋高亮
-- vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { desc = "Clear search highlights" })

-- -- ==============================================================================
-- -- 專案快捷鍵
-- -- ==============================================================================

-- vim.keymap.set("n", "<leader>sd", function()
--     -- :cd 命令會切換 Neovim 當前的工作目錄
--     -- vim.fn.expand("~") 會自動將 ~ 轉換為你的使用者主目錄
--     vim.cmd("cd " .. vim.fn.expand("~/development/Sutra"))
--     print("已切換至 Sutra 目錄")
-- end, { desc = "切換至 Sutra 專案目錄" })
