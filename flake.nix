{
  description = "Michael's Nvim Flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    mnw.url = "github:gerg-l/mnw";
  };

  outputs = {
    nixpkgs,
    mnw,
    ...
  }: let
    forAllSystems = nixpkgs.lib.genAttrs ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];
    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    devShells = forAllSystems (
      system: {
        default = import ./shell.nix {pkgs = nixpkgsFor.${system};};
      }
    );

    packages = forAllSystems (
      system: let
        pkgs = nixpkgsFor.${system};

        vimPlugins = with pkgs.vimPlugins; [
          neovim-ayu
          mini-nvim
          oil-nvim
          gitsigns-nvim
          todo-comments-nvim
          snacks-nvim
          nvim-lspconfig
        ];
      in {
        default = mnw.lib.wrap pkgs {
          neovim = pkgs.neovim-unwrapped;
          extraBinPath = with pkgs; [
            # General
            lazygit

            # Nix
            nil
            nixd
            alejandra

            # Lua
            luajitPackages.lua-lsp
          ];
          initLua = builtins.readFile ./nvim/init.lua;
          plugins = {
            start = vimPlugins;
            dev.config.pure = ./nvim;
          };
        };
      }
    );
  };
}
