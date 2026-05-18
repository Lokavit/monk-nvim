-- 1. 清除現有的高亮設定
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

-- 2. 設定主題名稱
vim.g.colors_name = "matrix"

-- ==============================================================================
-- 3. 定義顏色 (Highlight Groups) - 護眼寫作優化版
-- ==============================================================================

-- Normal: 將 bg 設為 "NONE" 即可實現「背景完全透明」，直接透出 Kitty 的半透明壁紙！
-- fg 設為舒服的乳白/淺灰 (#e3e3e3)，長時間碼字不刺眼
vim.api.nvim_set_hl(0, "Normal", { fg = "#e3e3e3", bg = "NONE" })

-- 行號欄也設置為背景透明
vim.api.nvim_set_hl(0, "LineNr", { fg = "#5c6370", bg = "NONE" })
-- 當前行號顯示為亮綠色，方便定位
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#4eee85", bg = "NONE", bold = true })

-- CursorLine: 游標所在行的背景，給一個非常低調的深灰，既能辨識又不會太搶眼
vim.api.nvim_set_hl(0, "CursorLine", { bg = "#212121" })

-- 註解顏色
vim.api.nvim_set_hl(0, "Comment", { fg = "#5c6370", italic = true })

-- 關鍵字顏色 (如 Lua 的 local, function)
vim.api.nvim_set_hl(0, "Keyword", { fg = "#4eee85", bold = true })

-- Markdown 專屬語法顏色（讓你的標題 # 變得非常醒目）
vim.api.nvim_set_hl(0, "Title", { fg = "#4eee85", bold = true })      -- # 一級標題
vim.api.nvim_set_hl(0, "Underlined", { fg = "#58a6ff", underline = true }) -- 超連結

-- ==============================================================================
-- 4. 絕對安全、純原生的 Markdown 視覺優化版 (不崩潰)
-- ==============================================================================

-- 1. 基礎文本樣式（利用 Vim 的 htmlBold 和 htmlItalic，這兩個很安全）
vim.api.nvim_set_hl(0, "htmlBold", { fg = "#ffb07c", bold = true })          -- 讓 **加粗** 變成純白加粗
vim.api.nvim_set_hl(0, "htmlItalic", { fg = "#a6da95", italic = true })      -- 讓 *斜體* 變成灰綠斜體
vim.api.nvim_set_hl(0, "htmlBoldItalic", { fg = "#4eee85", bold = true, italic = true })

-- 2. 借力打力：利用 Vim 底層的安全高亮組來映射 Markdown 元素
-- 代碼塊、行內代碼（Underlined/String 級別）：安全前景色，不加 bg 背景色
vim.api.nvim_set_hl(0, "Constant", { fg = "#a6e3a1" })        -- 這樣 `行內程式碼` 會有好看的薄荷綠

-- 列表符號 (-, *, 1.)：原生底層鏈接的是 Identifier
vim.api.nvim_set_hl(0, "Identifier", { fg = "#4eee85" })      -- 讓列表符號和特殊標記變成你的 Matrix 亮綠

-- 引用塊 (>)：原生底層鏈接的是 Comment 或 Special
vim.api.nvim_set_hl(0, "Special", { fg = "#8592a9", italic = true }) -- 讓 > 引用和一些特殊符號變成舒服的暗藍灰

-- 3. 超連結優化
vim.api.nvim_set_hl(0, "Underlined", { fg = "#58a6ff", underline = true }) -- 藍色超連結文本
