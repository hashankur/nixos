{ pkgs, ... }:
{
  fonts = {
    enableDefaultPackages = true;
    packages = [ pkgs.noto-fonts ];
    # Emoji fix
    fontconfig.useEmbeddedBitmaps = true;
  };
}
