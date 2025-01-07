require("config")
require("keymapping")


-- Plugins with lazy
local lazypath = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Настройка Lazy.nvim
require("lazy").setup({

-- Пример плагинов
  { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }, -- :TSU команда для запуска 
  { "nvim-lua/plenary.nvim" }, -- Библиотека для создания плагинов 
  {'Pocco81/auto-save.nvim'}, -- Автосохранение
-- Темы ---------------------------------- 
  {'rebelot/kanagawa.nvim'},
  {
    "rose-pine/neovim",
	name = "rose-pine",
	config = function()
	end },
  {"catppuccin/nvim", name = "catppuccin", priority = 1000},
  {
      'sainnhe/everforest',
      lazy = false,
      priority = 1000,
      config = function()
        vim.g.everforest_enable_italic = true
      end
  },


-- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  {'windwp/nvim-autopairs'}, -- автодобавление парных симвалов
  {'lukas-reineke/indent-blankline.nvim'}, -- визуальное отображение отступов
  {'hrsh7th/nvim-cmp'}, -- автокомплит
  {'hrsh7th/cmp-nvim-lsp'},
  {'saadparwaiz1/cmp_luasnip'},
  {'L3MON4D3/LuaSnip'}, -- Сниппеты
  {'jose-elias-alvarez/null-ls.nvim'}, -- Форматирование 
-- LSP --  
  {
      'neovim/nvim-lspconfig',
      config = function()
          local lspconfig = require('lspconfig')
      -- Пример настройки LSP для Python
      lspconfig.pyright.setup{}
      -- для языка lua
      lspconfig.lua_ls.setup {
        settings = {
            Lua = {
                runtime = {
        -- Укажите версию Lua, используемую в вашем проекте
                    version = 'LuaJIT',
                },
                diagnostics = {
        -- Распознавание глобальных переменных Neovim
                    globals = { 'vim' },
                },
                workspace = {
        -- Подключение библиотек Neovim
                    library = vim.api.nvim_get_runtime_file('', true),
                    checkThirdParty = false,
                    },
                telemetry = {
                    enable = false,
                },
            },
        },
    }
    end,
  },
})

-- Null-ls для Prettier (должен быть установлен в системе npm install -g prettier)
require('null-ls').setup({
    sources = {
        require('null-ls').builtins.formatting.prettier,
    }

})

-- Autocomplete settings
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {},
  mapping = {
    ['<C-e>'] = cmp.mapping.abort(), -- Закрыть меню
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Подтвердить выбор
    ['<C-p>'] = cmp.mapping.select_prev_item(), -- Навигация вверх
    ['<C-n>'] = cmp.mapping.select_next_item(), -- Навигация вниз
  },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- Источник из LSP
        { name = 'luasnip' },  -- Источник для сниппетов
    }),
})

-- Настройка nvim-autopairs
require('nvim-autopairs').setup{}

-- Настройка Indent-blankline визуальное отображение отступов
require("ibl").setup {
    indent = {
        char = "┊", -- Символ для отображения отступов
    },
    scope = {
        enabled = true, -- Включение подсветки областей (scope)
        show_start = true,
        show_end = false,
    },
}

-- Color scheme
--vim.cmd([[colorscheme kanagawa-wave]]) -- kanagawa-wave, kanagawa-dragon, kanagawa-lotus
--require("tokyonight").load() -- тема установлена вручную
--vim.cmd("colorscheme rose-pine-main")
--vim.cmd.colorscheme "catppuccin-mocha" -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
vim.cmd.colorscheme('everforest')
vim.g.everforest_background = 'soft'
-----------------------------

-- прозрачный фон
--vim.cmd([[
  --highlight Normal guibg=NONE ctermbg=NONE
  --highlight NonText guibg=NONE ctermbg=NONE
  --highlight LineNr guibg=NONE ctermbg=NONE
  --highlight EndOfBuffer guibg=NONE ctermbg=NONE
--]])

-- Запуск Python файлов
vim.api.nvim_set_keymap('n', '<leader>r', ':w<CR>:!python %<CR>', { noremap = true, silent = true })
