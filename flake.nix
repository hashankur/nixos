{
  # Description, write anything or even nothing
  description = "Han's NixOS Flake";

  # Input config, or package repos
  inputs = {
    # Nixpkgs, NixOS's official repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # ala-lape = {
    #   url = "git+https://git.madhouse-project.org/algernon/ala-lape.git";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    zen-browser = {
      # url = "github:MarceColl/zen-browser-flake";
      url = "github:MarceColl/zen-browser-flake?ref=pull/61/head";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Output config, or config for NixOS system
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      chaotic,
      niri,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        odyssey = lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            ./modules/nix.nix
            ./hosts/odyssey
            ./modules/core.nix
            ./modules/desktop.nix
            ./modules/dev.nix
            ./modules/gaming.nix
            ./modules/wm.nix
            ./modules/ssd.nix
            ./modules/terminal.nix
            chaotic.nixosModules.default
            niri.nixosModules.niri
            stylix.nixosModules.stylix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
              home-manager.users.han = import ./home-manager/han.nix;
            }
          ];
        };

        perseus = lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            ./modules/nix.nix
            ./hosts/perseus
            ./modules/core.nix
            ./modules/desktop.nix
            chaotic.nixosModules.default

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
              home-manager.users.merina = import ./home-manager/merina.nix;
            }
          ];
        };

        calypso = lib.nixosSystem {
          inherit system;
          specialArgs = inputs;
          modules = [
            ./modules/nix.nix
            ./hosts/calypso
            ./modules/core.nix
            # ./modules/desktop.nix
            chaotic.nixosModules.default
          ];
        };
      };
    };
}
