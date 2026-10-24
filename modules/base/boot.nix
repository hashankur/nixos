{ pkgs, ... }:
{
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;

    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };

    supportedFilesystems = [
      "btrfs"
      "ntfs"
    ];

    plymouth = {
      enable = true;
      themePackages = [ pkgs.plymouth-blahaj-theme ];
      theme = "blahaj";
    };

    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
