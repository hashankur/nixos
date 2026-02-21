{ pkgs, ... }:
{
  stylix = {
    enable = true;
    icons = {
      enable = true;
      package = pkgs.morewaita-icon-theme;
    };
    targets = {
      gtk.enable = false;
      spicetify.enable = false;
      qt = {
        enable = true;
        platform = "qtct";
      };
    };
  };
}
