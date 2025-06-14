{ pkgs, ... }:
{
  stylix = {
    enable = true;
    iconTheme = {
      enable = true;
      package = pkgs.morewaita-icon-theme;
    };
    targets = {
      # chromium.enable = false;
      gtk.enable = false;
      spicetify.enable = false;
      qt = {
        enable = true;
        platform = "qtct";
      };
    };
  };
}
