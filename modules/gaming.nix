{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # gamemode
    (bottles.override { removeWarningPopup = true; })
    # mangohud
    # gamescope
    # gnome.aisleriot
    # gnome.gnome-chess
    # ryujinx
    # lutris
    # umu.packages.${pkgs.system}.umu
    # wineWowPackages.stagingFull
  ];

  programs.steam = {
    enable = false;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = false; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  hardware.graphics = {
    ## radv: an open-source Vulkan driver from freedesktop
    enable32Bit = true;

    ## amdvlk: an open-source Vulkan driver from AMD
    # extraPackages = [ pkgs.amdvlk ];
    # extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };
}
