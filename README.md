
##Мой конфиг nvim

> Конфиг: `init.lua` | Leader: `<Space>` (пробел)

---

# 📋 Содержание

- [Базовые настройки](#-базовые-настройки)
- [Плагины и функционал](#-плагины-и-функционал)
- [🍿 Snacks.nvim — Горячие клавиши](#-snacksnvim--горячие-клавиши)
- [🌳 Neo-tree — Файловое дерево](#-neo-tree--файловое-дерево)

---

# ⚙️ Базовые настройки

| Настройка | Значение | Описание |
|-----------|----------|----------|
| `number` + `relativenumber` | true | Абсолютные + относительные номера строк |
| `tabstop` / `shiftwidth` | 4 | Размер табуляции 4 пробела |
| `expandtab` | false | Используются символы табуляции (tabs) |
| `termguicolors` | true | 24-bit цветовая палитра |
| `mapleader` | Space | Leader-ключ — пробел |
| `spell` + `spelllang` | en_us, ru | Проверка орфографии (английский + русский) |
| `clipboard` | WslClipboard | Буфер обмена через WSL (clip.exe / PowerShell) |
| `transparent` | enabled | Прозрачность фона окон |

---

# 🧩 Плагины и функционал

## 🎨 Интерфейс

| Плагин | Зависимости | Назначение |
|--------|------------|-----------|
| **oxocarbon.nvim** | — | Основная цветовая схема (Oxocarbon) |
| **kanagawa.nvim** | — | Альтернативная тема Kanagawa (с прозрачностью) |
| **nvim-web-devicons** | — | Цветные иконки для типов файлов |
| **dressing.nvim** | — | Красивые окна ввода (с скруглёнными краями) |
| **transparent.nvim** | — | Автоматическая прозрачность фона |
| **lualine.nvim** | `nvim-web-devicons` | Статус-строка с темой Oxocarbon |
| **barbar.nvim** | `nvim-web-devicons`, `gitsigns.nvim` | Вкладки открытых файлов сверху (табы) |
| **neo-tree.nvim** | `plenary.nvim`, `nvim-web-devicons`, `nui.nvim` | Боковое файловое дерево с навигацией и управлением файлами |

### Горячие клавиши Barbar (табы)

| Клавиши | Описание |
|---------|----------|
| `Alt + ←` | Предыдущая вкладка |
| `Alt + →` | Следующая вкладка |
| `Alt + c` | Закрыть вкладку |

---

## ✍️ Редактирование

| Плагин | Зависимости | Назначение |
|--------|------------|-----------|
| **nvim-autopairs** | — | Автозакрытие скобок, кавычек, тегов (интеграция с Treesitter) |
| **mini.surround** | — | Добавление/удаление/замена парных символов (`sa`, `sd`, `sr`, `sf`, `sF`, `sh`) |
| **Comment.nvim** | — | Комментирование строк (`gcc` / `gc` в визуальном режиме) |
| **nvim-ts-autotag** | — | Автозакрытие и переименование HTML/XML/TSX тегов |

---

## 🌳 Treesitter

| Плагин | Зависимости | Назначение |
|--------|------------|-----------|
| **nvim-treesitter** | — | Продвинутая подсветка синтаксиса + парсеры |

**Установленные языки:** html, css, javascript, typescript, lua, python, go

---

## 💡 LSP и автодополнение

| Плагин | Зависимости | Назначение |
|--------|------------|-----------|
| **mason.nvim** | — | Менеджер LSP-серверов и языковых инструментов |
| **mason-lspconfig.nvim** | `nvim-lspconfig` | Автоматическая конфигурация LSP |
| **nvim-lspconfig** | — | Настройка LSP-серверов |
| **nvim-cmp** | `cmp-nvim-lsp`, `LuaSnip`, `cmp_luasnip` | Автодополнение (LSP + сниппеты LuaSnip) |
| **LuaSnip** | — | Система сниппетов |

**Установленные LSP-серверы:** html, cssls, lua_ls, ts_ls, pyright, gopls

**Автодополнение:** `<C-Space>` — вызвать, `<CR>` — подтвердить

---

## 🎯 Форматирование

| Плагин | Зависимости | Назначение |
|--------|------------|-----------|
| **conform.nvim** | — | Форматирование кода при сохранении |

| Язык | Форматтер |
|------|----------|
| HTML / CSS / JS | prettier |
| Python | black |
| Go | gofmt + goimports |

---

## 🌿 Git

| Плагин | Зависимости | Назначение |
|--------|------------|-----------|
| **gitsigns.nvim** | — | Git-интеграция в статус-колонке + Git Blame по наведению |

| Клавиши | Описание |
|---------|----------|
| `]c` | Следующее изменение |
| `[c` | Предыдущее изменение |
| `]t` | Следующая TODO-заметка |
| `[t` | Предыдущая TODO-заметка |

---

## 🔖 TODO-комментарии

| Плагин | Зависимости | Назначение |
|--------|------------|-----------|
| **todo-comments.nvim** | `plenary.nvim` | Подсветка и навигация по TODO/FIXME/HACK/WARN заметкам в коде |

| Клавиши | Описание |
|---------|----------|
| `]t` | Следующая TODO-заметка |
| `[t` | Предыдущая TODO-заметка |
| `<Space> s t` | Поиск всех TODO по проекту (через Snacks picker) |

---

## 🛠️ Утилиты

| Плагин | Зависимости | Назначение |
|--------|------------|-----------|
| **snacks.nvim** | — | Универсальный набор утилит: пикеры, терминал, zen-режим, scratch-буферы, навигация по словам, отмена, диагностика и др. |
| **neodev.nvim** | — | Поддержка Lua-типизации для Neovim-плагинов |

---

# 🍿 Snacks.nvim — Горячие клавиши

> Конфиг: `init.lua` | Leader: `<Space>` (пробел)

---

## 📂 Навигация по файлам

| Клавиши | Описание |
|---------|----------|
| `<Space> <Space>` | Smart Find Files — умный поиск файлов |
| `<Space> ,` | Buffers — переключение открытых буферов |
| `<Space> f f` | Find Files — поиск файлов |
| `<Space> f c` | Find Config File — поиск файлов конфигурации |
| `<Space> f b` | Buffers — список буферов |
| `<Space> f g` | Find Git Files — файлы из git |
| `<Space> f p` | Projects — проекты |
| `<Space> f r` | Recent — недавние файлы |
| `<Space> e` | Neo-tree — файловое дерево (toggle) |

---

## 🔍 Поиск и grep

| Клавиши | Описание |
|---------|----------|
| `<Space> /` | Grep — поиск по файлам |
| `<Space> s b` | Buffer Lines — поиск по строкам текущего буфера |
| `<Space> s B` | Grep Open Buffers — grep по открытым буферам |
| `<Space> s g` | Grep — поиск по файлам |
| `<Space> s t` | Todo Comments — поиск всех TODO/FIXME/HACK по проекту |
| `<Space> s w` | Visual selection or word — поиск выделенного или слова |
| `<Space> s /` | Search History — история поиска |
| `<Space> s "` | Registers — содержимое регистров |

---

## 🔧 Команды и настройки

| Клавиши | Описание |
|---------|----------|
| `<Space> :` | Command History — история команд |
| `<Space> s C` | Commands — все команды |
| `<Space> s c` | Command History — история команд |
| `<Space> s a` | Autocmds — автокоманды |
| `<Space> s R` | Resume — продолжить последний поиск |
| `<Space> s S` | LSP Workspace Symbols — символы в workspace |

---

## 📊 Диагностика и отладка

| Клавиши | Описание |
|---------|----------|
| `<Space> s d` | Diagnostics — диагностика (все файлы) |
| `<Space> s D` | Buffer Diagnostics — диагностика текущего буфера |
| `<Space> n` | Notification History — история уведомлений |
| `<Space> un` | Dismiss All Notifications — закрыть все уведомления |

---

## 📖 Справочная информация

| Клавиши | Описание |
|---------|----------|
| `<Space> s h` | Help Pages — страницы помощи |
| `<Space> s M` | Man Pages — man страницы |
| `<Space> s H` | Highlights — highlight группы |
| `<Space> s i` | Icons — иконки |
| `<Space> s j` | Jumps — история переходов |
| `<Space> s k` | Keymaps — горячие клавиши |
| `<Space> s m` | Marks — метки |
| `<Space> u C` | Colorschemes — цветовые схемы |

---

## 📋 Списки

| Клавиши | Описание |
|---------|----------|
| `<Space> s l` | Location List — список location |
| `<Space> s q` | Quickfix List — список quickfix |
| `<Space> s u` | Undo History — история отмен |

---

## 🌿 Git

| Клавиши | Описание |
|---------|----------|
| `<Space> g b` | Git Branches — ветки |
| `<Space> g l` | Git Log — лог |
| `<Space> g L` | Git Log Line — лог для текущей строки |
| `<Space> g s` | Git Status — статус |
| `<Space> g S` | Git Stash — стэши |
| `<Space> g d` | Git Diff (Hunks) — дифф |
| `<Space> g f` | Git Log File — лог файла |
| `<Space> g B` | Git Browse — открыть в браузере (v: режим) |
| `<Space> g g` | Lazygit — запустить lazygit |

---

## 🐙 GitHub

| Клавиши | Описание |
|---------|----------|
| `<Space> g i` | GitHub Issues (open) — открытые issues |
| `<Space> g I` | GitHub Issues (all) — все issues |
| `<Space> g p` | GitHub Pull Requests (open) — открытые PR |
| `<Space> g P` | GitHub Pull Requests (all) — все PR |

---

## 💻 LSP

| Клавиши | Описание |
|---------|----------|
| `g d` | Goto Definition — перейти к определению |
| `g D` | Goto Declaration — перейти к декларации |
| `g r` | References — все ссылки |
| `g I` | Goto Implementation — перейти к реализации |
| `g y` | Goto Type Definition — перейти к типу |
| `g a i` | Calls Incoming — входящие вызовы |
| `g a o` | Calls Outgoing — исходящие вызовы |
| `<Space> s s` | LSP Symbols — символы в файле |

---

## 🎛️ Утилиты

| Клавиши | Описание |
|---------|----------|
| `<Space> z` | Toggle Zen Mode — режим зен (без отвлечения) |
| `<Space> Z` | Toggle Zoom — полноэкранный режим |
| `<Space> .` | Toggle Scratch Buffer — временный буфер |
| `<Space> S` | Select Scratch Buffer — выбор временного буфера |
| `<Space> bd` | Delete Buffer — удалить буфер |
| `<Space> c R` | Rename File — переименовать файл |
| `<C-/>` | Toggle Terminal — терминал |
| `<C-_>` | Toggle Terminal — терминал (альтернатива) |

---

## 🔤 Поиск по словам (words)

| Клавиши | Описание |
|---------|----------|
| `]]` | Next Reference — следующая ссылка на слово |
| `[[` | Prev Reference — предыдущая ссылка на слово |

---

## ⚙️ Тогглы (`<Space> u`)

| Клавиши | Описание |
|---------|----------|
| `<Space> u s` | Spelling — проверка орфографии |
| `<Space> u w` | Wrap — перенос строк |
| `<Space> u L` | Relative Number — относительные номера строк |
| `<Space> u d` | Diagnostics — диагностика |
| `<Space> u l` | Line Number — номера строк |
| `<Space> u c` | Conceallevel — уровень сокрытия |
| `<Space> u T` | Treesitter — подсветка синтаксиса |
| `<Space> u b` | Dark Background — тёмный фон |
| `<Space> u h` | Inlay Hints — подсказки |
| `<Space> u g` | Indent — отступы |
| `<Space> u D` | Dim — затемнение неактивных областей |

---

## 📰 Дополнительно

| Клавиши | Описание |
|---------|----------|
| `<Space> N` | Neovim News — новости Neovim |
| `<Space> s p` | Search for Plugin Spec — поиск спецификации плагина |

---

# 🌳 Neo-tree — Файловое дерево

> Плагин: `nvim-neo-tree/neo-tree.nvim` (v3.x) | Leader: `<Space>` (пробел)

Боковая панель с файловым деревом проекта. Открывается слева, автоматически следует за текущим буфером.

## ⚙️ Настройки

| Параметр | Значение | Описание |
|----------|----------|----------|
| `close_if_last_window` | true | Закрывает дерево, если оно осталось единственным окном |
| `width` | 45 | Ширина боковой панели (символы) |
| `hide_dotfiles` | false | Показывать скрытые файлы (`.gitignore` и т.д.) |
| `hide_gitignored` | false | Показывать файлы, игнорируемые git |
| `follow_current_file` | true | Автоподсветка текущего файла в дереве |

## ⌨️ Горячие клавиши

| Клавиши | Описание |
|---------|----------|
| `<Space> e` | Открыть/закрыть дерево (toggle) |
| `Enter` | Открыть файл / раскрыть или свернуть папку |
| `a` | Создать новый файл или папку (для папки добавьте `/` в конце, напр. `styles/`) |
| `d` | Удалить выбранный файл/папку |
| `r` | Переименовать файл |
| `c` | Скопировать (Copy) |
| `x` | Вырезать (Cut) |
| `p` | Вставить (Paste) |
| `H` | Показать/скрыть скрытые файлы |
| `q` | Закрыть панель дерева |


