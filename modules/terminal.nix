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
    zoxide
    # warp-terminal
    # nushell
    rio
  ];
}
