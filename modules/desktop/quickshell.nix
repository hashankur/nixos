{ config, lib, pkgs, qml-language-server, qml-niri, ... }:
{
  options.my.desktop.quickshell.enable = lib.mkEnableOption "quickshell shell and QML tooling";

  config = lib.mkIf config.my.desktop.quickshell.enable {
    environment.systemPackages = with pkgs; [
      quickshell
      qt6Packages.qtdeclarative
      qml-niri.packages."${pkgs.stdenv.hostPlatform.system}".default
      qml-language-server.packages."${pkgs.stdenv.hostPlatform.system}".default
    ];

    qt = {
      enable = true;
      platformTheme = lib.mkDefault "qtct";
    };
  };
}
