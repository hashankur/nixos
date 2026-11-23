{
  lib,
  pkgs,
  helium,
  zen-browser,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.plymouth = {
    theme = "sliced";
    themePackages = with pkgs; [
      # By default we would install all themes
      (adi1090x-plymouth-themes.override {
        selected_themes = [ "sliced" ];
      })
    ];
  };

  # system.nixos-init.enable = true;

  my = {
    dev.enable = true;
    gaming.enable = true;
    ssd.enable = true;
    terminal.enable = true;
    desktop = {
      apps.enable = true;
      niri.enable = true;
      quickshell.enable = true;
      stylix.enable = true;
      umbriel.enable = true;
    };
  };

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
      shell = pkgs.fish;
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zen-browser.packages."${pkgs.stdenv.hostPlatform.system}".beta
    helium.packages."${pkgs.stdenv.hostPlatform.system}".default

    ## Office
    typst

    mission-center

    qbittorrent

    thunderbird
    slack
  ];

  programs.localsend.enable = true;

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

    openssh.enable = false;

    flatpak.enable = true;

    cloudflare-warp.enable = true;

    # fwupd.enable = true;

    jellyfin = {
      enable = false;
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

  # Development ports
  networking.firewall.allowedTCPPorts = [
    3000
    3001
    8000
    8081
    8082

  ];
  networking.firewall.allowedUDPPorts = [
    # 7236
    # 5353
  ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
