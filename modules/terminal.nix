{
  config,
  lib,
  pkgs,
  ...
}:
{
  options.my.terminal.enable = lib.mkEnableOption "terminal tooling (fish, zoxide, ghostty, ...)";

  config = lib.mkIf config.my.terminal.enable {
    environment.systemPackages = with pkgs; [
      starship
      eza
      helix
      yadm
      lazygit
      ghostty
    ];

    programs = {
      fish.enable = true;
      zoxide.enable = true;
      nix-index.enable = true;
    };
  };
}
