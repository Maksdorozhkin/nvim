
##Мой конфиг nvim

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
| `<Space> e` | File Explorer — файловый браузер |

---

## 🔍 Поиск и grep

| Клавиши | Описание |
|---------|----------|
| `<Space> /` | Grep — поиск по файлам |
| `<Space> s b` | Buffer Lines — поиск по строкам текущего буфера |
| `<Space> s B` | Grep Open Buffers — grep по открытым буферам |
| `<Space> s g` | Grep — поиск по файлам |
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


