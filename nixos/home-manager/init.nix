{
  credentials,
  home-manager,
  inputs,
  config,
  ...
}:
{

  # HOME MANAGER
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.${credentials.user.name} =
    { lib, pkgs, ... }:
    let
      myMain = import ./main.nix {
        inherit
          inputs
          pkgs
          lib
          credentials
          config
          ;
      };
    in
    {
      imports = [
        myMain
      ];
    };

}
