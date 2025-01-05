{ pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # # Auto login Gnome
  # services.displayManager.autoLogin = {
  #   enable = true;
  #   user = "elmo";
  # };
  # # Workaround for crash on login
  # systemd.services."getty@tty1".enable = false;
  # systemd.services."autovt@tty1".enable = false;

  networking = {
    hostName = "calypso"; # Define your hostname.
    # Enables wireless support via wpa_supplicant.
    wireless.enable = false;
    # Enable networking
    networkmanager.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users = {
      elmo = {
        isNormalUser = true;
        description = "Elmo";
        extraGroups = [
          "networkmanager"
          "wheel"
          "video"
        ];
        # shell = pkgs.fish;
      };
      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGOVFuQxjN0p1oSUTfb2LOcirE7w3dwDvAEp1KYTSBlm han@odyssey"
        ];
      };
    };
  };
  environment.systemPackages = with pkgs; [
    brave
    firefox
    btop
    fastfetch
  ];

  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    auto-cpufreq.settings = {
      charger = {
        governor = "powersave";
        turbo = "auto";
      };
    };

    jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965";
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
