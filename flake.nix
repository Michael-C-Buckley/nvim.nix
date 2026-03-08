{
  description = "Michael's Nvim Flake";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    mnw.url = "github:gerg-l/mnw";
  };

  outputs = {
    self,
    nixpkgs,
    mnw,
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

        vimPlugins = import ./nix/plugins.nix {inherit pkgs;};
      in {
        nvim = self.packages.${system}.default;
        default = mnw.lib.wrap pkgs {
          extraBinPath = import ./nix/binPath.nix {inherit pkgs;};
          initLua = builtins.readFile ./nvim/init.lua;
          plugins = {
            inherit (vimPlugins) start;
            opt = vimPlugins.lazy;
            dev.config.pure = ./nvim;
          };
          providers.python3 = {
            enable = true;
            extraPackages = p:
              with p; [
                debugpy
                pynvim
              ];
          };
        };
      }
    );
  };
}
