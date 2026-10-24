{ config, lib, ... }:
{
  options.my.gaming.enable = lib.mkEnableOption "gaming support (steam, 32-bit graphics)";

  config = lib.mkIf config.my.gaming.enable {
    programs.steam = {
      enable = false;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      localNetworkGameTransfers.openFirewall = true;
    };

    hardware.graphics.enable32Bit = true;
  };
}
