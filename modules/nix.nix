{ nixpkgs, ... }:
{
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    optimise.automatic = true;
    registry.nixpkgs.flake = nixpkgs; # Reuse system nixpkgs for flakes
    settings = {
      # Slows down write operations considerably?
      # auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      builders-use-substitutes = true;
      substituters = [ "https://attic.xuyh0120.win/lantian" ];

      trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

      trusted-users = [
        "root"
        "han"
      ];
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
