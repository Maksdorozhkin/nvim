local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{'phaazon/hop.nvim'},

{
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker"
    }
},
{'nvim-treesitter/nvim-treesitter'},
{'neovim/nvim-lspconfig'},
-- Прозрачный фон
{'xiyaowong/nvim-transparent'},
-- Zephyr
{'nvimdev/zephyr-nvim'},
-- Papadark
{'MordechaiHadad/nvim-papadark'},
{'rktjmp/lush.nvim'},
--Catppuccin
{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },
-- Gruvbox theme
{'morhetz/gruvbox'},
-- Kanagawa
{'humbertocarmona/kanagawa-mod.nvim'},

{'hrsh7th/cmp-nvim-lsp'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'}, {'hrsh7th/cmp-cmdline'}, {'hrsh7th/nvim-cmp'},
{'williamboman/mason.nvim'},
{'nvim-telescope/telescope.nvim', tag = '0.1.2', dependencies = {'nvim-lua/plenary.nvim'}},
{'jose-elias-alvarez/null-ls.nvim'},
{'windwp/nvim-autopairs'},
{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
--
{
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons', 'linrongbin16/lsp-progress.nvim'
 }       },
--
{'terrortylor/nvim-comment'},
{'lewis6991/gitsigns.nvim'},
{'akinsho/toggleterm.nvim'},
}) 
