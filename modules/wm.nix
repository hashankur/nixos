{ niri, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # hyprlock
    swayidle
    # hyprpicker
    # wlsunset
    gammastep
    # wluma
    playerctl
    libnotify
    # pamixer
    swww
    waybar
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
    bemenu # wayland clone of dmenu
    # clipse

    encfs
    gocryptfs
    zenity
    sshfs
    jq
    socat
    bc
    ripgrep
    fd
    xwayland-satellite-unstable
    wl-mirror

    soteria

    matugen
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
      # iosevka-bin
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
        name = "Inter";
        package = pkgs.inter;
      };
      sansSerif = {
        name = "Inter";
        package = pkgs.inter;
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
}
