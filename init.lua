-- 1. Автоматическая установка менеджера плагинов lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- 2. Основные настройки интерфейса
-- Использовать Fish в качестве системной оболочки для Neovim
vim.opt.shell = "/usr/bin/fish"
vim.opt.number = true         -- Номера строк
vim.opt.relativenumber = true -- Относительные номера
vim.opt.tabstop = 4           -- Размер табуляции
vim.opt.shiftwidth = 4
vim.opt.expandtab = true      -- По умолчанию пробелы (Python, и т.д.)
vim.opt.conceallevel = 2      -- Скрывает символы форматирования, заменяя их на иконки для md файлов
vim.opt.clipboard = "unnamedplus"
vim.opt.showmode = false      -- убирает mode

-- Табы для Go, Lua, JS/TS (вместо глобального expandtab = false)
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go", "lua", "javascript", "typescript" },
	callback = function()
		vim.opt_local.expandtab = false
	end,
})
vim.opt.termguicolors = true -- Поддержка 24-bit цветов
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Проверка орфографии
vim.opt.spell = true                  -- Включить проверку орфографии
vim.opt.spelllang = { 'en_us', 'ru' } -- Использовать английский и русский

-- 3. Список плагинов
require("lazy").setup({
	-- Поддержка Lua для самого конфига
	{ "folke/neodev.nvim" },

	-- База иконок для всех плагинов интерфейса
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false, -- Загружаем сразу, чтобы иконки появились на заставке и в дереве
		config = function()
			require("nvim-web-devicons").setup({
				-- Включаем цветные иконки (они отлично подстроятся под Oxocarbon)
				color_icons = true,
				-- Настройка по умолчанию (если формат файла неизвестен)
				default = true,
			})
		end,
	},


	-- Современное и красивое файловое дерево Neo-tree
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- Ваши иконки
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true, -- Закрывать дерево, если оно осталось единственным окном
				filesystem = {
					filtered_items = {
						visible = true, -- Показывать скрытые файлы (например, .gitignore) полупрозрачными
						hide_dotfiles = false,
						hide_gitignored = false,
					},
					follow_current_file = {
						enabled = true, -- Автоматически раскрывать папки до файла, который сейчас открыт
					},
				},
				window = {
					width = 45, -- Ширина боковой панели
					mappings = {
						["<space>"] = "none", -- Освобождаем пробел, чтобы не ломать ваши лидер-клавиши
					},
				},
			})
		end,
		keys = {
			-- Назначаем открытие Neo-tree на ту же привычную комбинацию <Пробел> + e
			{ "<leader>e", "<cmd>Neotree toggle left<cr>", desc = "Neo-tree (File Explorer)" },
		},
	},


	-- Современный дизайн окон ввода
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
		config = function()
			require("dressing").setup({
				input = {
					enabled = true,
					default_prompt = "Input:",
					title_pos = "left",
					insert_only = true,
					start_in_insert = true,
					border = "rounded", -- Красивые скругленные края окон
					relative = "cursor",
				},
			})
		end,
	},

	-- Подсветка и поиск TODO заметок в коде
	{
		"folke/todo-comments.nvim",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup({
				-- Ваши иконки отобразятся корректно благодаря Hack NF
				signs = true,
			})
		end,
		keys = {
			-- Быстрый прыжок к следующей заметке в файле
			{ "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo" },
			-- Быстрый прыжок к предыдущей заметке
			{ "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo" },
		},
	},



	-- Подсветка и переименование парных тегов
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup({
				opts = {
					enable_close = true, -- Автозакрытие тегов при вводе `>`
					enable_rename = true, -- Синхронное переименование тегов
					enable_close_on_slash = true, -- Автозакрытие при вводе `/`
				},
			})
		end,
	},


	-- Автозакрытие скобок и кавычек
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter", -- Загружается только при переходе в режим ввода
		config = function()
			local autopairs = require("nvim-autopairs")
			autopairs.setup({
				check_ts = true, -- Интеграция с Treesitter (не ставит скобки внутри комментариев или строк)
				ts_config = {
					lua = { "string" }, -- Не добавлять пары в строках Lua
					javascript = { "template_string" },
				},
			})

			local cmp_status, cmp = pcall(require, "cmp")
			if cmp_status then
				local cmp_autopairs = require("nvim-autopairs.completion.cmp")
				cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
			end
		end,
	},

	-- Быстрое добавление/удаление/изменение кавычек и скобок
	{
		"echasnovski/mini.surround",
		version = false, -- Используем актуальную версию
		config = function()
			require("mini.surround").setup({
				-- Список горячих клавиш:
				mappings = {
					add = "sa", -- Add: добавить скобки/кавычки вокруг выделения или движения
					delete = "sd", -- Delete: удалить скобки/кавычки вокруг курсора
					find = "sf", -- Find: найти следующую пару
					find_left = "sF",
					highlight = "sh", -- Highlight: подсветить пару скобок
					replace = "sr", -- Replace: заменить одни скобки/кавычки на другие
					update_n_lines = "sn",
				},
			})
		end,
	},

	-- Gitsigns (включает показ автора строки)
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				-- Включает показ автора строки при наведении (Git Blame)
				current_line_blame = true,
				current_line_blame_opts = {
					delay = 500, -- Показать через полсекунды задержки курсора
				},
			})
		end,
		keys = {
			-- Прыгнуть к следующему изменению в файле
			{ "]c", "<cmd>Gitsigns next_hunk<CR>", desc = "Next Git Change" },
			-- Прыгнуть к предыдущему изменению
			{ "[c", "<cmd>Gitsigns prev_hunk<CR>", desc = "Prev Git Change" },
		},
	},


	-- Nvim-Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				ensure_installed = { "html", "css", "javascript", "typescript", "lua", "python", "go", "markdown", "markdown_inline" },
				highlight = { enable = true },
			})
		end,
	},

	-- Snacks
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			color = { enabled = true },
			terminal = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = false },
			indent = { enabled = true },
			input = { enabled = true },
			notifier = {
				enabled = true,
				timeout = 3000,
			},
			picker = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
			styles = {
				notification = {
					-- wo = { wrap = true } -- Wrap notifications
				},
			},
		},
		keys = {
			-- Top Pickers & Explorer
			{ "<leader><space>", function() Snacks.picker.smart() end,                                   desc = "Smart Find Files" },
			{ "<leader>,",       function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
			{ "<leader>/",       function() Snacks.picker.grep() end,                                    desc = "Grep" },
			{ "<leader>:",       function() Snacks.picker.command_history() end,                         desc = "Command History" },
			{ "<leader>n",       function() Snacks.picker.notifications() end,                           desc = "Notification History" },
			-- Быстрое открытие терминала
			{ "<leader>t",       function() Snacks.terminal.toggle() end,                                desc = "Toggle Terminal" },
			-- find
			{ "<leader>fb",      function() Snacks.picker.buffers() end,                                 desc = "Buffers" },
			{ "<leader>fc",      function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
			{ "<leader>ff",      function() Snacks.picker.files() end,                                   desc = "Find Files" },
			{ "<leader>fg",      function() Snacks.picker.git_files() end,                               desc = "Find Git Files" },
			{ "<leader>fp",      function() Snacks.picker.projects() end,                                desc = "Projects" },
			{ "<leader>fr",      function() Snacks.picker.recent() end,                                  desc = "Recent" },
			-- git
			{ "<leader>gb",      function() Snacks.picker.git_branches() end,                            desc = "Git Branches" },
			{ "<leader>gl",      function() Snacks.picker.git_log() end,                                 desc = "Git Log" },
			{ "<leader>gL",      function() Snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
			{ "<leader>gs",      function() Snacks.picker.git_status() end,                              desc = "Git Status" },
			{ "<leader>gS",      function() Snacks.picker.git_stash() end,                               desc = "Git Stash" },
			{ "<leader>gd",      function() Snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
			{ "<leader>gf",      function() Snacks.picker.git_log_file() end,                            desc = "Git Log File" },
			-- gh
			{ "<leader>gi",      function() Snacks.picker.gh_issue() end,                                desc = "GitHub Issues (open)" },
			{ "<leader>gI",      function() Snacks.picker.gh_issue({ state = "all" }) end,               desc = "GitHub Issues (all)" },
			{ "<leader>gp",      function() Snacks.picker.gh_pr() end,                                   desc = "GitHub Pull Requests (open)" },
			{ "<leader>gP",      function() Snacks.picker.gh_pr({ state = "all" }) end,                  desc = "GitHub Pull Requests (all)" },
			-- Grep
			{ "<leader>sB",      function() Snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
			{ "<leader>sg",      function() Snacks.picker.grep() end,                                    desc = "Grep" },
			{ "<leader>sw",      function() Snacks.picker.grep_word() end,                               desc = "Visual selection or word",   mode = { "n", "x" } },
			-- search
			{ '<leader>s"',      function() Snacks.picker.registers() end,                               desc = "Registers" },
			{ '<leader>s/',      function() Snacks.picker.search_history() end,                          desc = "Search History" },
			{ "<leader>sa",      function() Snacks.picker.autocmds() end,                                desc = "Autocmds" },
			{ "<leader>sb",      function() Snacks.picker.lines() end,                                   desc = "Buffer Lines" },
			{ "<leader>sc",      function() Snacks.picker.command_history() end,                         desc = "Command History" },
			{ "<leader>sC",      function() Snacks.picker.commands() end,                                desc = "Commands" },
			{ "<leader>sd",      function() Snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
			{ "<leader>sD",      function() Snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
			{ "<leader>sh",      function() Snacks.picker.help() end,                                    desc = "Help Pages" },
			{ "<leader>sH",      function() Snacks.picker.highlights() end,                              desc = "Highlights" },
			{ "<leader>si",      function() Snacks.picker.icons() end,                                   desc = "Icons" },
			{ "<leader>sj",      function() Snacks.picker.jumps() end,                                   desc = "Jumps" },
			{ "<leader>sk",      function() Snacks.picker.keymaps() end,                                 desc = "Keymaps" },
			{ "<leader>sl",      function() Snacks.picker.loclist() end,                                 desc = "Location List" },
			{ "<leader>sm",      function() Snacks.picker.marks() end,                                   desc = "Marks" },
			{ "<leader>sM",      function() Snacks.picker.man() end,                                     desc = "Man Pages" },
			{ "<leader>sp",      function() Snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
			{ "<leader>sq",      function() Snacks.picker.qflist() end,                                  desc = "Quickfix List" },
			{ "<leader>sR",      function() Snacks.picker.resume() end,                                  desc = "Resume" },
			{ "<leader>su",      function() Snacks.picker.undo() end,                                    desc = "Undo History" },
			{ "<leader>uC",      function() Snacks.picker.colorschemes() end,                            desc = "Colorschemes" },
			-- Поиск всех TODO заметок по всему проекту (через встроенный поисковик snacks)
			{ "<leader>st",      function() require("snacks").picker.todo_comments() end,                desc = "Todo Comments" },


			-- LSP
			{ "gd",              function() Snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
			{ "gD",              function() Snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
			{ "gr",              function() Snacks.picker.lsp_references() end,                          nowait = true,                       desc = "References" },
			{ "gI",              function() Snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
			{ "gy",              function() Snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
			{ "gai",             function() Snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming" },
			{ "gao",             function() Snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing" },
			{ "<leader>ss",      function() Snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
			{ "<leader>sS",      function() Snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
			-- Other
			{ "<leader>z",       function() Snacks.zen() end,                                            desc = "Toggle Zen Mode" },
			{ "<leader>Z",       function() Snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
			{ "<leader>.",       function() Snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
			{ "<leader>S",       function() Snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
			-- { "<leader>n",       function() Snacks.notifier.show_history() end,                          desc = "Notification History" },
			{ "<leader>bd",      function() Snacks.bufdelete() end,                                      desc = "Delete Buffer" },
			{ "<leader>cR",      function() Snacks.rename.rename_file() end,                             desc = "Rename File" },
			{ "<leader>gB",      function() Snacks.gitbrowse() end,                                      desc = "Git Browse",                 mode = { "n", "v" } },
			{ "<leader>gg",      function() Snacks.lazygit() end,                                        desc = "Lazygit" },
			{ "<leader>un",      function() Snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
			{ "<c-/>",           function() Snacks.terminal() end,                                       desc = "Toggle Terminal" },
			{ "<c-_>",           function() Snacks.terminal() end,                                       desc = "which_key_ignore" },
			{ "]]",              function() Snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",             mode = { "n", "t" } },
			{ "[[",              function() Snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",             mode = { "n", "t" } },
			{
				"<leader>N",
				desc = "Neovim News",
				function()
					Snacks.win({
						file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
						width = 0.6,
						height = 0.6,
						wo = {
							spell = false,
							wrap = false,
							signcolumn = "yes",
							statuscolumn = " ",
							conceallevel = 3,
						},
					})
				end,
			}
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					-- Setup some globals for debugging (lazy-loaded)
					_G.dd = function(...)
						Snacks.debug.inspect(...)
					end
					_G.bt = function()
						Snacks.debug.backtrace()
					end

					-- Override print to use snacks for `:=` command
					if vim.fn.has("nvim-0.11") == 1 then
						vim._print = function(_, ...)
							dd(...)
						end
					else
						vim.print = _G.dd
					end

					-- Create some toggle mappings
					Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
					Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
					Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
					Snacks.toggle.diagnostics():map("<leader>ud")
					Snacks.toggle.line_number():map("<leader>ul")
					Snacks.toggle.option("conceallevel",
						{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
					Snacks.toggle.treesitter():map("<leader>uT")
					Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map(
						"<leader>ub")
					Snacks.toggle.inlay_hints():map("<leader>uh")
					Snacks.toggle.indent():map("<leader>ug")
					Snacks.toggle.dim():map("<leader>uD")
				end,
			})
		end,
	},

	-- CMP
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			{ "L3MON4D3/LuaSnip", version = "v2.*", build = "make install_jsregexp" },
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
				}),
			})
		end,
	},

	-- Mason
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		config = function()
			local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
			if status then
				vim.lsp.config("*", {
					capabilities = cmp_nvim_lsp.default_capabilities(),
				})
			end

			require("mason-lspconfig").setup({
				ensure_installed = { "html", "cssls", "lua_ls", "ts_ls", "pyright", "gopls" },
				automatic_enable = true,
			})
		end,
	},
	{
		'MeanderingProgrammer/render-markdown.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter', -- Обязательно для работы парсеров
			'nvim-tree/nvim-web-devicons' -- Нужен для красивых иконок
		},
		ft = { 'markdown', 'codecompanion' }, -- Загружается только для MD файлов
		opts = {
			-- Базовые настройки (можно оставить пустыми для дефолтных)
			heading = {
				-- Меняет значки заголовков #, ##, ### на более аккуратные
				icons = { '🢂 ', '🢂 ', '🢂 ', '🢂 ', '🢂 ', '🢂 ' },
			},
			checkbox = {
				-- Красивые галочки для списков задач
				unchecked = { icon = '   ' },
				checked = { icon = ' ' },
			},
		},
	},


	-- Форматирование кода при сохранении
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" }, -- Запуск строго перед сохранением
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				html = { "prettier" },
				css = { "prettier" },
				javascript = { "prettier" },
				python = { "black" }, -- Стандартный форматирщик для Python
				go = { "gofmt", "goimports" },
			},
			format_on_save = {
				timeout_ms = 3000,
				lsp_format = "fallback",
			},
		},
	},
	-- Красивая статус-строка внизу
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("lualine").setup({ options = { theme = "onedark" } })
		end,
	},

	-- Вкладки открытых файлов сверху (Табы)
	{
		"romgrk/barbar.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons", "lewis6991/gitsigns.nvim" },
		init = function() vim.g.barbar_auto_setup = false end,
		config = function() require("barbar").setup() end,
		keys = {
			-- Переключение между вкладками через Alt + стрелочки
			{ "<A-,>", "<cmd>BufferPrevious<cr>", desc = "Previous Tab" },
			{ "<A-.>", "<cmd>BufferNext<cr>",     desc = "Next Tab" },
			-- Закрыть текущую вкладку через Alt + c
			{ "<A-c>", "<cmd>BufferClose<cr>",    desc = "Close Tab" },
		},
	},
	-- Коментарии Нажмите gcc на любой строке, чтобы закомментировать её. Нажмите gcc еще раз, чтобы раскомментировать. В визуальном режиме (v) выделите блок и нажмите gc
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Темы
	{ "nyoom-engineering/oxocarbon.nvim" },
	{ "rebelot/kanagawa.nvim" },
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require('onedark').setup {
				style = 'dark',
			}
			require('onedark').load()
		end
	}
})

-- -- Тема
-- vim.cmd("colorscheme oxocarbon")
-- vim.cmd("colorscheme kanagawa")
vim.cmd("colorscheme onedark")
--
-- 4. Автокоманда для принудительной прозрачности окон
-- (Срабатывает при инициализации любой темы, гарантируя отсутствие серого фона)
vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		-- ИСПРАВЛЕНО: Добавлены группы "Normal" и "NonText" для полной прозрачности Oxocarbon
		local groups = { "Normal", "NormalFloat", "SignColumn", "LineNr", "CursorLineNr", "NonText" }
		for _, group in ipairs(groups) do
			vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
		end
	end,
})

vim.g.clipboard = {
	name = 'WslClipboard',
	copy = {
		['+'] = 'clip.exe',
		['*'] = 'clip.exe',
	},
	paste = {
		['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard))',
		['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard))',
	},
	cache_enabled = 0,
}
vim.filetype.add({ extension = { gotmpl = "gotmpl" } })
