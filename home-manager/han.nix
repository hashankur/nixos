{ ... }:
{
  home.stateVersion = "24.05";

  # add the home manager module
  imports = [
    ./ags.nix
    ./spicetify.nix
    ./stylix.nix # see wm.nix for global stylix
  ];

  # Use XDG config
  programs.niri.config = null;
