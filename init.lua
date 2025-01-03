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
  {'rebelot/kanagawa.nvim'}, -- Тема рабочего стола
  {'windwp/nvim-autopairs'}, -- автодобавление парных симвалов
  {'hrsh7th/nvim-cmp'}, -- автокомплит
  {'hrsh7th/cmp-nvim-lsp'},
  {'saadparwaiz1/cmp_luasnip'},
  {'L3MON4D3/LuaSnip'}, -- Сниппеты
  {'jose-elias-alvarez/null-ls.nvim'}, -- Форматирование 
-- LSP ------------------------------------------------------------------------------------  
  {
      'neovim/nvim-lspconfig', 
      config = function() 
          local lspconfig = require('lspconfig')
      -- Пример настройки LSP для Python
      lspconfig.pyright.setup{}
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
  completion = {
--    autocomplete = false, -- Отключить автоматическое появление
  },
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

-- Color scheme
vim.cmd([[colorscheme kanagawa-wave]]) -- kanagawa-wave, kanagawa-dragon, kanagawa-lotus
--require("tokyonight").load() -- тема установлена вручную

-- прозрачный фон
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])


