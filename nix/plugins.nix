{pkgs}: {
  start = with pkgs.vimPlugins; [
    mini-nvim
    snacks-nvim
    neovim-ayu

    luasnip
    friendly-snippets
    nvim-dap
  ];

  lazy = with pkgs.vimPlugins;
    [
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
    ]
    ++ [
      (nvim-treesitter.withPlugins (p:
        with p; [
          tree-sitter-lua
          tree-sitter-nix
          tree-sitter-python
        ]))
    ];
}
