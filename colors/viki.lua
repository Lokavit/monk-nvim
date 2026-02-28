-- 1. 清除現有的高亮設定
vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

-- 2. 設定主題名稱
vim.g.colors_name = "viki"

-- 3. 定義顏色 (Highligth Groups)
-- 例如：設定背景色和前景(字)色
vim.api.nvim_set_hl(0, "Normal", { fg = "#d6e8ee", bg = "#0e1923" })
-- 設定註解顏色
vim.api.nvim_set_hl(0, "Comment", { fg = "#5c6370", italic = true })
-- 設定關鍵字顏色 (如 function, local, if)
vim.api.nvim_set_hl(0, "Keyword", { fg = "#eceae5", bold = true })