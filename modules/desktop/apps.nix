{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.desktop.apps.enable = lib.mkEnableOption "everyday desktop apps (gimp, mpv, libreoffice, ...)";

  config = lib.mkIf config.my.desktop.apps.enable {
    environment.systemPackages = with pkgs; [
      ## Media
      gimp
      inkscape
      mpv

      ## Office
      libreoffice-stable

      tealdeer
      btop
      fastfetch
      killall
      unrar
      libnotify

      adw-gtk3
    ];
  };
}
