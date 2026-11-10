{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  options.my.desktop.umbriel.enable = lib.mkEnableOption "umbriel compositor session";

  config = lib.mkIf config.my.desktop.umbriel.enable {
    programs.umbriel.enable = true;

    # Screenshots run from the neue quickshell config: grim captures, ImageMagick crops.
    environment.systemPackages = [
      pkgs.grim
      pkgs.imagemagick
      inputs.amane.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];
  };
}
