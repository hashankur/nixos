{ ... }:
{
  home.stateVersion = "24.05";

  # add the home manager module
  imports = [
    ./modules/spicetify.nix
  ];
}
