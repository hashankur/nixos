{
  lib,
  pkgs,
  zen-browser,
  winapps,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.plymouth = {
    theme = lib.mkForce "sliced";
    themePackages = with pkgs; [
      # By default we would install all themes
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "sliced" ];
      })
    ];
  };

  # system.nixos-init.enable = true;

  networking = {
    hostName = "odyssey"; # Define your hostname.
    # Enable networking
    networkmanager.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.han = {
      isNormalUser = true;
      description = "Hashan";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "docker"
        "adbusers"
        "vboxusers"
        "kvm"
        "dialout"
      ];
      shell = pkgs.nushell;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # obsidian
    # brave
    zen-browser.packages."${system}".beta
    # (vivaldi.override {
    #   proprietaryCodecs = true;
    #   enableWidevine = true;
    # })

    ## Media
    # handbrake
    # obs-studio
    # pitivi
    # avidemux

    ## Office
    # xournalpp
    # zathura
    typst
    # staruml
    zotero

    distrobox
    # megasync
    # colmena
    mission-center

    # anydesk
    # varia
    qbittorrent
    # gnome-network-displays
    # jellyfin-mpv-shim
    # delfin
    # upscayl
    thonny

    winapps.packages."${system}".winapps
    winapps.packages."${system}".winapps-launcher
  ];

  fileSystems."/mnt/Storage" = {
    device = "/dev/nvme0n1p5";
    fsType = "ntfs";
  };

  services = {
    syncthing = {
      enable = false;
      user = "han";
      configDir = "/home/han/.config/syncthing";
      overrideFolders = false;
      guiAddress = "127.0.0.1:5050";
      openDefaultPorts = true;
    };

    tailscale.enable = true;

    openssh.enable = true;

    flatpak.enable = true;

    cloudflare-warp.enable = true;

    # fwupd.enable = true;

    jellyfin = {
      enable = true;
      openFirewall = true;
      user = "han";
    };

    # jellyseerr.enable = true;

    kanata = {
      enable = true;
      keyboards = {
        "minimal" = {
          config = builtins.readFile ../../modules/kanata/minimal.scm;
        };
      };
    };
  };

  # virtualisation.virtualbox.host.enable = true;

  # virtualisation.waydroid.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    # Development ports
    3000
    3001
    8081

    # 7236
    # 7250
  ];
  networking.firewall.allowedUDPPorts = [
    # 7236
    # 5353
  ];
  # networking.firewall.trustedInterfaces = [ "p2p-wl+" ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
