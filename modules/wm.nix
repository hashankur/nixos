{
  lib,
  pkgs,
  qml-language-server,
  qml-niri,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    hyprlock
    swayidle
    # wlinhibit
    # wlsunset
    gammastep
    # wluma
    playerctl
    libnotify
    # pamixer
    awww
    brightnessctl
    # dunst

    # Screenshot
    # grim
    # sway-contrib.grimshot
    # slurp

    # Clipboard
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    cliphist
    fzf
    # clipse

    # encfs
    gocryptfs
    zenity
    sshfs
    jq
    # socat
    # bc
    ripgrep
    fd
    xwayland-satellite
    wl-mirror

    soteria

    matugen
    morewaita-icon-theme

    # sherlock-launcher

    quickshell
    qt6Packages.qtdeclarative
    qml-niri.packages."${pkgs.stdenv.hostPlatform.system}".default
    qml-language-server.packages."${pkgs.stdenv.hostPlatform.system}".default
  ];

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.symbols-only
      iosevka-bin
      inter
    ];
  };

  stylix = {
    enable = true;
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/kx/wallhaven-kxvqp7.jpg";
      sha256 = "sha256-0p49GSybwWbaxK/AbLMtUXLdvg5KhiIJ/G2Mubhd5tA=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
    };
    fonts = {
      serif = {
        name = "Outfit";
      };
      sansSerif = {
        name = "Outfit";
      };
      monospace = {
        name = "Iosevka";
        package = pkgs.iosevka-bin;
      };
      emoji = {
        name = "Twitter Color Emoji";
        package = pkgs.twitter-color-emoji;
      };
    };
    targets = {
      gnome.enable = false;
      gtk.enable = false;
      plymouth.enable = false;
      gtksourceview.enable = false; # Causes recompilation
    };
  };

  qt = {
    enable = true;
    platformTheme = lib.mkDefault "qtct";
  };

  programs = {
    niri = {
      enable = true;
      useNautilus = true;
    };

    xwayland = {
      enable = true;
    };
  };

  # xdg.portal = {
  #   enable = true;
  #   config = {
  #     niri = {
  #       default = [
  #         "gnome"
  #         "gtk"
  #       ];
  #       "org.freedesktop.impl.portal.Access" = "gnome";
  #       "org.freedesktop.impl.portal.FileChooser" = "gnome";
  #       "org.freedesktop.impl.portal.Notification" = "gnome";
  #       "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
  #     };
  #   };
  #   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  # };
}
