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

  # This affects directory name. Do NOT change!
  # I use Momo as my primary username now but I don't
  # want to change the directory path.
  home-manager.users.${credentials.userName} =
    { pkgs, ... }:
    let
      myMain = import ./main.nix {
        pkgs = pkgs;
        inputs = inputs;
        credentials = credentials;
        config = config;
      };
    in
    {
      imports = [
        myMain
      ];
    };

}
