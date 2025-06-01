{ inputs, pkgs, ... }:
{
  imports = [
    inputs.ags.homeManagerModules.default
  ];

  home.packages =
    with inputs.ags.packages.${pkgs.system};
    [
      io
      notifd
    ]
    ++ [ pkgs.imagemagick ];

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
      niri
      notifd
      tray
      wireplumber
    ];
  };
}
