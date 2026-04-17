{pkgs}:
pkgs.buildEnv {
  name = "nvim-devshell-runtime-env";
  pathsToLink = ["/bin"];
  paths = with pkgs; [
    # Formatting
    mdformat
    alejandra
    treefmt
    stylua

    # Lua
    stylua
    selene

    # Nix
    deadnix
    statix
    nil

    # Hooks
    typos
  ];
}
