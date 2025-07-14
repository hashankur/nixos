{ pkgs, zen-browser, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  networking = {
    hostName = "odyssey"; # Define your hostname.
    # Enables wireless support via wpa_supplicant.
    wireless.enable = false;
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
    obsidian
    brave
    zen-browser.packages."${system}".beta

    ## Media
    # handbrake
    obs-studio
    # pitivi

    ## Office
    # xournalpp
    # zathura
    # typst
    # staruml
    zotero

    distrobox
    # megasync
    # colmena
    mission-center

    anydesk
    # varia
    qbittorrent
  ];

  # List services that you want to enable:
  services = {
    # Syncthing
    syncthing = {
      enable = true;
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
    8081 # For Expo
  ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
