{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # tdesktop

    ## Media
    # tauon
    gimp
    inkscape
    # foliate
    mpv
    jellyfin-media-player

    ## Office
    libreoffice-fresh

    tealdeer
    btop
    fastfetch
    wget2
    killall
    unrar
    libnotify

    # gnome-tweaks
    adw-gtk3
  ];
}
