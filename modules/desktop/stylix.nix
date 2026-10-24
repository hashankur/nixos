{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    iosevka-bin
    inter
  ];

  stylix = {
    enable = true;
    polarity = "dark";
    image = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/kx/wallhaven-kxvqp7.jpg";
      sha256 = "sha256-0p49GSybwWbaxK/AbLMtUXLdvg5KhiIJ/G2Mubhd5tA=";
    };
    base16Scheme = "${pkgs.base16-schemes}/share/themes/ayu-dark.yaml";
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 20;
    };
    fonts = {
      serif.name = "Outfit";
      sansSerif.name = "Outfit";
      monospace = {
        name = "Iosevka";
        package = pkgs.iosevka-bin;
      };
      emoji = {
        name = "Twitter Color Emoji";
        package = pkgs.twitter-color-emoji;
      };
    };
    targets = {
      gnome.enable = false;
      gtk.enable = false;
      plymouth.enable = false;
      gtksourceview.enable = false; # Causes recompilation
    };
  };
}
