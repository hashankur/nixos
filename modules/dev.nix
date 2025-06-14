{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    ## Editor / IDE
    vscode.fhs
    zed-editor-fhs_git
    # arduino-ide

    ## Compilers / Runtimes
    nodejs
    bun
    gcc
    rustup
    # gleam
    # uv # Python package and project manager

    ## Tools
    # contrast
    # gaphor
    # scrcpy
    nh
    # docker-compose
    devenv

    ## LSP
    # nil
    nixfmt-rfc-style
    nixd
    nil
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.typescript-language-server
    nodePackages_latest.prettier
    nodePackages_latest."@tailwindcss/language-server"
    marksman
    # lua-language-server
    biome
    taplo
    clang-tools
  ];

  programs = {
    git = {
      enable = true;
      config = {
        init = {
          defaultBranch = "main";
        };
      };
    };

    adb.enable = true;

    java = {
      enable = true;
      package = pkgs.temurin-bin;
    };

    direnv.enable = false;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        ## From nixpkgs `android-studio` package ##

        # Crash at startup without these
        fontconfig
        freetype
        xorg.libXext
        xorg.libXi
        xorg.libXrender
        xorg.libXtst

        alsa-lib
        dbus
        expat
        libbsd
        libpulseaudio
        libuuid
        xorg.libX11
        xorg.libxcb
        libxkbcommon
        xorg.xcbutilwm
        xorg.xcbutilrenderutil
        xorg.xcbutilkeysyms
        xorg.xcbutilimage
        xorg.xcbutilcursor
        xorg.libICE
        xorg.libSM
        xorg.libxkbfile
        xorg.libXcomposite
        xorg.libXcursor
        xorg.libXdamage
        xorg.libXfixes
        libGL
        libdrm
        libpng
        nspr
        nss_latest
        systemd

        # For GTKLookAndFeel
        gtk2
        glib

        # For wayland support
        wayland
      ];
    };
  };

  # services = {
  #   mysql = {
  #     enable = false;
  #     package = pkgs.mariadb;
  #   };
  # };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
  };
}
