{ inputs, pkgs, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages = with inputs.ags.packages.${pkgs.system}; [
    io
    notifd
  ];

  programs.ags = {
    enable = true;
    # null or path, leave as null if you don't want hm to manage the config
    configDir = null;
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      apps
      # auth
      battery
      bluetooth
      mpris
      network
      notifd
      tray
      wireplumber
    ];
  };
}
