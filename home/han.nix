{ ... }:
{
  home.stateVersion = "24.05";

  # add the home manager module
  imports = [
    ./modules/spicetify.nix
    ./modules/stylix.nix # system-wide stylix lives in modules/desktop/stylix.nix
  ];
}
