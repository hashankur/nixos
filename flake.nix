{
  # Description, write anything or even nothing
  description = "Han's NixOS Flake";

  # Input config, or package repos
  inputs = {
    # Nixpkgs, NixOS's official repo
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    astal = {
      # url = "path:./overlays/astal/patched-astal"; # local patched source (PR-70 + applied PR-417)
      url = "github:Aylur/astal?ref=pull/70/head"; # Niri lib
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags = {
      url = "github:Aylur/ags";
      inputs.astal.follows = "astal";
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

    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Output config, or config for NixOS system
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
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

            # home-manager.nixosModules.home-manager
            # {
            #   home-manager.useGlobalPkgs = true;
            #   home-manager.useUserPackages = true;
            #   home-manager.extraSpecialArgs = {
            #     inherit inputs;
            #   };
            #   home-manager.users.merina = import ./home-manager/merina.nix;
            # }
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
          ];
        };
      };
    };
}
