vim.opt.encoding = "utf-8"       -- Общая кодировка (необязательно, по умолчанию UTF-8)
vim.opt.fileencoding = "utf-8"  -- Кодировка файлов
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = true
vim.opt.cursorline = false -- Disable highlight current cursor's line
vim.opt.swapfile = false -- Disable .swp files 
vim.opt.scrolloff = 7 -- Number of lines left visible above/below the cursor when scrolling
vim.opt.tabstop = 4 -- Spaces instead of one tab
vim.opt.softtabstop = 4 -- Spaces instead of one tab
vim.opt.shiftwidth = 4 -- Spaces for auto indent
vim.opt.expandtab = true -- Replace tab with spaces
vim.opt.autoindent = true -- Save indent on new line
vim.opt.fileformat = "unix"
vim.opt.smartindent = true
vim.opt.splitbelow = true -- horizontal split open below and right
vim.opt.splitright = true
vim.opt.termguicolors = true -- 24-bit colors
-- Установить язык сообщений на русский
vim.cmd('language messages ru_RU.UTF-8')
-- Установить язык документации на русский
vim.opt.helplang = 'ru'
vim.opt.clipboard = "unnamedplus" -- использование системного буфера обмена
vim.g.netrw_banner = 0 -- убирает все лишнее из стандартного Explorer
vim.g.netrw_liststyle = 3 -- дерево каталогов в Explorer
vim.g.netrw_hide = 1 -- убирает скрытые файлы в Explorer 
vim.opt.termguicolors = true -- 24-bit colors
vim.opt.splitbelow = true -- horizontal split open below and right
-- vim.opt.guicursor = "" -- делает курсор стандартным
vim.opt.colorcolumn = "80" -- вертикальная линия pep8
