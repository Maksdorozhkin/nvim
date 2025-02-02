require("config")

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
  {'ryanoasis/vim-devicons'}, -- иконки файлов
  {'nvim-telescope/telescope.nvim', tag = '0.1.8'}, -- поиск
  {
    "xiyaowong/transparent.nvim",
    config = function()
      require("transparent").setup({
        extra_groups = {
          "NormalFloat", -- плавающие окна
          "NvimTreeNormal", -- фон nvim-tree
          "StatusLine", -- строка состояния
        },
      })
    end,
  },
--- Темы ---------------------------------- 
  { "EdenEast/nightfox.nvim" },
  { "bluz71/vim-moonfly-colors", name = "moonfly", lazy = false, priority = 1000 },
  {"nyoom-engineering/oxocarbon.nvim"},
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
  {"lunarvim/synthwave84.nvim"},
-- -- -- -- -- -- -- -- -- -- -- -- -- -- 
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" }},
  {'windwp/nvim-autopairs'}, -- автодобавление парных симвалов
  {'lukas-reineke/indent-blankline.nvim'}, -- визуальное отображение отступов
  {'hrsh7th/nvim-cmp'}, -- автокомплит
  {'hrsh7th/cmp-nvim-lsp'},
  {'saadparwaiz1/cmp_luasnip'},
  {'L3MON4D3/LuaSnip'}, -- Сниппеты
  {'jose-elias-alvarez/null-ls.nvim'}, -- Форматирование 
  { 'numToStr/Comment.nvim', config = true }, -- Коментирование строк gcc, gc visual mode
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


-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' }) -- поиск по файлам 
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' }) -- поиск по слову 
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' }) -- поиск по буферу
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' }) -- поиск по help tags 



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
-- Nvim-tree
require("nvim-tree").setup({
  disable_netrw = true,
  hijack_netrw = true,
  hijack_cursor = false,
  hijack_unnamed_buffer_when_opening = false,
  update_cwd = false,
  respect_buf_cwd = false,
  -- Настройки отображения
  view = {
    width = 45, -- ширина окна
    side = "left", -- расположение (left или right)
    number = false,
    relativenumber = false,
    signcolumn = "yes", -- отображение знаков (например, для диагностики)
  },

  -- Настройки иконок
  renderer = {
    indent_markers = {
      enable = true, -- отображение маркеров отступов
    },
    icons = {
      glyphs = {
        default = "", -- иконка по умолчанию
        symlink = "", -- иконка для символьных ссылок
        folder = {
          arrow_closed = "", -- иконка закрытой папки
          arrow_open = "", -- иконка открытой папки
          default = "", -- иконка папки по умолчанию
          open = "", -- иконка открытой папки
          empty = "", -- иконка пустой папки
          empty_open = "", -- иконка открытой пустой папки
          symlink = "", -- иконка папки-символьной ссылки
          symlink_open = "", -- иконка открытой папки-символьной ссылки
        },
      },
    },
  },
  -- Настройки действий
  actions = {
    open_file = {
      quit_on_open = false, -- закрыть nvim-tree после открытия файла
      window_picker = {
        enable = true, -- разрешить выбор окна для открытия файла
      },
    },
  },
  -- Настройки фильтров
  filters = {
    dotfiles = false, -- показывать скрытые файлы (начинающиеся с .)
    custom = {}, -- пользовательские фильтры
  },
  -- Настройки обновления
  update_focused_file = {
    enable = true, -- обновлять дерево при смене файла
    update_cwd = false, -- обновлять текущую рабочую директорию
  },
})
-- ~/.config/nvim/init.lua
vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

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

-- lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Color scheme
-- vim.cmd([[colorscheme kanagawa-wave]]) -- kanagawa-wave, kanagawa-dragon, kanagawa-lotus
-- require("tokyonight").load() -- тема установлена вручную
-- vim.cmd("colorscheme rose-pine-main")
-- vim.cmd.colorscheme "catppuccin-mocha" -- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
--vim.cmd.colorscheme('everforest')
--vim.g.everforest_background = 'soft'
-- vim.cmd[[colorscheme synthwave84]]
-- require 'synthwave84'.setup({
--   glow = {
--     error_msg = true,
--     type2 = true,
--     func = true,
--     keyword = true,
--     operator = false,
--     buffer_current_target = true,
--     buffer_visible_target = true,
--     buffer_inactive_target = true,
--   }
-- })
-- Тема oxocarbon
-- vim.opt.background = "dark"
-- vim.cmd.colorscheme "oxocarbon"
vim.cmd [[colorscheme moonfly]] -- супер тема
-- vim.cmd("colorscheme carbonfox") -- nightfox, carbonfox

