require'nvim-treesitter.configs'.setup {
  ensure_installed = { "typescript","css","python","rust", "lua", "bash", "tsx", "javascript" },

  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
