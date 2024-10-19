{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tdesktop

    ## Media
    # tauon
    gimp
    inkscape
    # foliate
    mpv

    ## Office
    libreoffice-fresh

    tealdeer
    btop
    fastfetch
    wget2
    killall
    unrar
    libnotify

    gnome-tweaks
    adw-gtk3
  ];

  programs = {
    fish.enable = true;
  };

  # ZRAM
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };
}
