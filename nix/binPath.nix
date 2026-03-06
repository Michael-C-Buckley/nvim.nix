{pkgs}:
with pkgs; [
  # General
  lazygit

  # Nix
  nil
  nixd
  alejandra

  # Lua
  luajitPackages.lua-lsp
  stylua
]
