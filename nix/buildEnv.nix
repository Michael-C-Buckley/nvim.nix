{pkgs}:
pkgs.buildEnv {
  name = "Michael's Nvim Env";
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
    lefthook
    typos
  ];
}
