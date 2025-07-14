{ niri, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    hyprlock
    swayidle
    # wlinhibit
    # hyprpicker
    # wlsunset
    gammastep
    # wluma
    playerctl
    libnotify
    # pamixer
    swww
    # waybar
    brightnessctl
    dunst

    # Screenshot
    # grim
    # sway-contrib.grimshot
    # slurp

    # Clipboard
    wl-clipboard # wl-copy and wl-paste for copy/paste from stdin / stdout
    cliphist
    fzf
    # clipse

    encfs
    # gocryptfs
    zenity
    sshfs
    jq
    # socat
    # bc
    ripgrep
    fd
    xwayland-satellite-unstable
    wl-mirror

    soteria

    matugen
    morewaita-icon-theme

    # sherlock-launcher
  ];

  nixpkgs.overlays = [ niri.overlays.niri ];

  environment.sessionVariables = {
    # Hint electron apps to use wayland
    NIXOS_OZONE_WL = "1";
  };

  fonts = {
    packages = with pkgs; [
      # (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; })
      nerd-fonts.symbols-only
      iosevka-bin
      # inter
      # noto-fonts-color-emoji
      # twitter-color-emoji
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
        name = "Adwaita Sans";
        package = pkgs.adwaita-fonts;
      };
      sansSerif = {
        name = "Adwaita Sans";
        package = pkgs.adwaita-fonts;
      };
      monospace = {
        name = "Adwaita Mono";
        package = pkgs.adwaita-fonts;
      };
      emoji = {
        name = "Twitter Color Emoji";
        package = pkgs.twitter-color-emoji;
      };
    };
    targets = {
      plymouth.enable = false;
    };

  };

  qt = {
    enable = true;
    # platformTheme = lib.mkDefault "qt5ct";
  };

  programs = {
    niri = {
      enable = true;
      package = pkgs.niri-stable;
    };

    xwayland = {
      enable = true;
    };
  };

  systemd = {
    user.services.niri-flake-polkit.enable = false;
  };

  # xdg.portal = {
  #   enable = true;
  #   config = {
  #     common = {
  #       default = "wlr";
  #     };
  #   };
  #   wlr.enable = true;
  #   wlr.settings.screencast = {
  #     output_name = "eDP-1";
  #     chooser_type = "simple";
  #     chooser_cmd = "${pkgs.slurp}/bin/slurp -f %o -or";
  #   };
  # };

  xdg.portal = {
    enable = true;
    config = {
      niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Access" = "gnome";
        "org.freedesktop.impl.portal.FileChooser" = "gnome";
        "org.freedesktop.impl.portal.Notification" = "gnome";
        "org.freedesktop.impl.portal.Secret" = "gnome-keyring";
      };
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
