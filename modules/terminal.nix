{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    starship
    eza
    # ranger
    # kitty
    helix
    yadm
    # zellij
    lazygit
    # navi
    # yazi
    # warp-terminal
    # rio
    ghostty
  ];

  programs = {
    fish = {
      enable = true;
    };

    zoxide = {
      enable = true;
    };

    nix-index.enable = true;
  };
}
