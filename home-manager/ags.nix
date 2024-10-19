{ inputs, pkgs, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = [ inputs.astal.packages.${pkgs.system}.default ];

  programs.ags = {
    enable = true;
    # null or path, leave as null if you don't want hm to manage the config
    configDir = null;
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      apps
      # auth
      # bluetooth
      mpris
      # network
      # notifd
      # powerprofiles
      # tray
      wireplumber
      # battery
      pkgs.fzf
      pkgs.dart-sass
      inputs.astal.packages.${pkgs.system}.default
    ];
  };
}
