{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.dev.enable = lib.mkEnableOption "development tools, runtimes and docker";

  config = lib.mkIf config.my.dev.enable {
    # nixpkgs only packages opencode 1.x; use local v2 (beta) until
    # https://github.com/NixOS/nixpkgs/pull/569770 lands
    nixpkgs.overlays = [
      (final: _: { opencode2 = final.callPackage ../packages/opencode2/default.nix { }; })
    ];

    environment.systemPackages = with pkgs; [
      ## Editor / IDE
      zed-editor-fhs

      ## Compilers / Runtimes
      nodejs

      ## Tools
      nh
      docker-compose
      devenv
      lazydocker
      opencode2
      gnumake
      claude-code
      tmux
      tmuxp
      harlequin

      ## LSP
      nixd
      nil
      taplo
      clang-tools
    ];

    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_16;
      settings.port = 5435;
      ensureUsers = [
        {
          name = "han";
          ensureClauses = {
            superuser = true;
            createdb = true;
          };
        }
      ];
      authentication = ''
        host all all 127.0.0.1/32 trust
        host all all ::1/128      trust
      '';
    };

    programs = {
      git = {
        enable = true;
        config.init.defaultBranch = "main";
      };

      java.enable = true;
      direnv.enable = true;

      nix-ld = {
        enable = true;
        libraries = with pkgs; [
          ## From nixpkgs `android-studio` package ##

          # Crash at startup without these
          fontconfig
          freetype
          libxext
          libxi
          libxrender
          libxtst

          alsa-lib
          dbus
          expat
          libbsd
          libpulseaudio
          libuuid
          libx11
          libxcb
          libxkbcommon
          libxcb-wm
          libxcb-render-util
          libxcb-keysyms
          libxcb-image
          libxcb-cursor
          libice
          libsm
          libxkbfile
          libxcomposite
          libxcursor
          libxdamage
          libxfixes
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

    virtualisation.docker = {
      enable = true;
      rootless.enable = true;
    };
  };
}
