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
      in {
        default = mnw.lib.wrap pkgs {
          neovim = pkgs.neovim-unwrapped;
          extraBinPath = with pkgs; [lazygit];
          initLua =
            # lua
            ''
              require("utility")
              require("languages.nix")
              require('ayu').colorscheme()
            '';
          plugins = {
            start = with pkgs.vimPlugins; [
              neovim-ayu
              mini-nvim
              oil-nvim
              gitsigns-nvim
              todo-comments-nvim
              snacks-nvim
            ];
            dev.myconfig.pure = ./config;
          };
        };
      }
    );
  };
}
