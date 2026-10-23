{ ... }:
{
  home.stateVersion = "24.05";

  # add the home manager module
  imports = [
    # ./modules/ags.nix
    ./modules/spicetify.nix
    ./modules/stylix.nix # see wm.nix for global stylix
    # ./modules/nushell.nix
  ];
}
