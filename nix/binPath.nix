{pkgs}:
with pkgs; [
  # General
  git
  lazygit

  # Nix
  nil
  nixd
  alejandra

  # Lua
  lua-language-server
  stylua

  # Python
  basedpyright
  ruff

  # Json
  vscode-json-languageserver
]
