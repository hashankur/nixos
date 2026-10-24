{ config, lib, pkgs, ... }:
{
  options.my.desktop.niri.enable = lib.mkEnableOption "niri compositor and its helper tools";

  config = lib.mkIf config.my.desktop.niri.enable {
    programs = {
      niri = {
        enable = true;
        useNautilus = true;
      };
      xwayland.enable = true;
    };
  
    environment.sessionVariables = {
      # Hint electron apps to use wayland
      NIXOS_OZONE_WL = "1";
    };
  
    environment.systemPackages = with pkgs; [
      hyprlock
      swayidle
      gammastep
      playerctl
      libnotify
      awww
      brightnessctl
  
      # Clipboard
      wl-clipboard
      cliphist
      fzf
  
      gocryptfs
      zenity
      sshfs
      jq
      ripgrep
      fd
      xwayland-satellite
      wl-mirror
  
      soteria
  
      matugen
      morewaita-icon-theme
    ];
  };
}
