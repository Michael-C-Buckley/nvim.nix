{pkgs}:
with pkgs.vimPlugins;
  [
    # Plugin Packs
    mini-nvim
    snacks-nvim

    # Themes
    neovim-ayu

    # Language
    nvim-lspconfig
    conform-nvim

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
  ++ [
    (nvim-treesitter.withPlugins (p:
      with p; [
        tree-sitter-lua
        tree-sitter-nix
      ]))
  ]
