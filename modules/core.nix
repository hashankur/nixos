# Baseline shared by every host.
{
  imports = [
    ./base/boot.nix
    ./base/fonts.nix
    ./base/hardware.nix
    ./base/locale.nix
    ./base/memory.nix
    ./desktop/gnome.nix
  ];
}
