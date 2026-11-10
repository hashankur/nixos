# Every module is imported everywhere; hosts opt in via `my.*.enable`.
{ inputs, ... }:
{
  imports = [
    ./nix.nix
    ./core.nix
    ./dev.nix
    ./gaming.nix
    ./ssd.nix
    ./terminal.nix
    ./desktop/apps.nix
    ./desktop/niri.nix
    ./desktop/quickshell.nix
    ./desktop/stylix.nix
    ./desktop/umbriel.nix
    inputs.stylix.nixosModules.stylix
  ];
}
