{ lib, pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  my.desktop.apps.enable = true;

  networking = {
    hostName = "perseus"; # Define your hostname.
    # Enables wireless support via wpa_supplicant.
    wireless.enable = lib.mkForce false;
    # Enable networking
    networkmanager.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      merina = {
        isNormalUser = true;
        description = "Merina";
        extraGroups = [
          "networkmanager"
          "wheel"
          "video"
          "dialout"
        ];
      };
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJqBF4ubUR5n+a9YTCIZroTPcmk48AtS6rfDkeZmBptL han@odyssey"
        ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    firefox
    obsidian
    # arduino-ide
    obs-studio
    parabolic
    # blender
    # handbrake
    bottles

    (python3.withPackages (ps: with ps; [ tkinter ]))
    vscode.fhs
    nodejs

    gnomeExtensions.caffeine
    # gnomeExtensions.pano # removed from nixpkgs
    gnomeExtensions.tiling-shell
  ];

  programs = {
    fish.enable = true;
  };

  systemd.tpm2.enable = false;
  boot.initrd.systemd.tpm2.enable = false;

  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    flatpak.enable = true;

    syncthing = {
      enable = false;
      user = "merina";
      configDir = "/home/merina/.config/syncthing";
      overrideFolders = false;
      guiAddress = "127.0.0.1:5050";
      openDefaultPorts = true;
    };

    # mysql = {
    #   enable = true;
    #   package = pkgs.mariadb;
    # };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
