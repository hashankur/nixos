{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    # Emoji fix
    fontconfig.useEmbeddedBitmaps = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
    ];
  };
}
