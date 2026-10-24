{ config, lib, ... }:
{
  options.my.ssd.enable = lib.mkEnableOption "SSD/btrfs tuning (trim, scrub, noatime, zstd)";

  config = lib.mkIf config.my.ssd.enable {
    services = {
      fstrim.enable = true;
      btrfs.autoScrub.enable = true;
    };

    fileSystems."/".options = [
      "noatime"
      "compress=zstd"
    ];
  };
}
