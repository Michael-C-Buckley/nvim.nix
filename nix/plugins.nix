{pkgs}: let
  grammars = map (a: pkgs.lib.concatStrings ["tree-sitter-" a]) [
    "bash"
    "lua"
    "nix"
    "python"
    "nu"
    "json"
    "go"
    "rust"
    "markdown"
    "diff"
    "yang"
  ];
in {
  start = builtins.attrValues {
    inherit
      (pkgs.vimPlugins)
      mini-nvim
      snacks-nvim
      neovim-ayu
      luasnip
      friendly-snippets
      nvim-dap
      ;

    treesitter =
      pkgs.vimPlugins.nvim-treesitter.withPlugins (p: map (a: p.${a}) grammars);
  };

  lazy = with pkgs.vimPlugins; [
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

    # Debug
    nvim-dap-ui
    nvim-dap-python

    # Extra Themes
    kanso-nvim
    bamboo-nvim
    kanagawa-nvim
    gruvbox-nvim
    tokyonight-nvim
    catppuccin-nvim
  ];
}
