{pkgs}:
with pkgs.vimPlugins; [
  # Plugin Packs
  mini-nvim
  snacks-nvim

  # Themes
  neovim-ayu

  # Language
  nvim-lspconfig

  # Navigation
  oil-nvim

  # UI
  gitsigns-nvim
  todo-comments-nvim

  # Completion
  blink-cmp
  luasnip
  friendly-snippets
]
