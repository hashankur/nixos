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

    # Default theme; odyssey sets its own.
    plymouth.enable = true;

    kernelParams = [
      "quiet"
      "splash"
    ];
  };
}
