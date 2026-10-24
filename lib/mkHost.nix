# Builds a nixosSystem with the shared plumbing (specialArgs, home-manager).
{ inputs }:
{
  name,
  system ? "x86_64-linux",
  modules ? [ ],
  # attrset of username -> home-manager module
  homeUsers ? { },
}:
inputs.nixpkgs.lib.nixosSystem {
  inherit system;
  specialArgs = inputs // { inherit inputs; };
  modules =
    [
      ../modules
      ../hosts/${name}
    ]
    ++ modules
    ++ inputs.nixpkgs.lib.optionals (homeUsers != { }) [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "backup";
          extraSpecialArgs = { inherit inputs; };
          users = homeUsers;
        };
      }
    ];
}
