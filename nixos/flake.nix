{
  description = ''
    Main NixOS configuration
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      home-manager,
      ...
    }@inputs:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem rec {
          system = "x86_64-linux";
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
          modules =
            let
              publicCredentials = import ./public-credentials.nix;
              myNetworking = import ./networking.nix {
                credentials = publicCredentials;
              };
              myTimeZone = import ./timezone.nix;
              myI18n = import ./i18n.nix;
              myFonts = import ./fonts.nix;
              mySound = import ./sound.nix;
              myDesktopEnvironment = import ./desktop-environment.nix;
              mySystemPackages = import ./system-packages.nix {
                pkgs = pkgs;
                inputs = inputs;
                credentials = publicCredentials;
              };
              mySystemUsers = import ./system-users.nix {
                credentials = publicCredentials;
                pkgs = pkgs;
              };
              myHomeManager = import ./home-manager/init.nix {
                credentials = publicCredentials;
                home-manager = home-manager;
                inputs = inputs;
                config = pkgs.config;
              };

            in
            [
              ./configuration.nix
              myNetworking
              myTimeZone
              myI18n
              myFonts
              mySound
              myDesktopEnvironment
              mySystemPackages
              mySystemUsers

              home-manager.nixosModules.default
              myHomeManager

              (
                { pkgs, lib, ... }:
                {

                  # Enable zRAM for better memory performance.
                  zramSwap.enable = true;

                  # Keep flake sources that are present with unremoved generations.
                  # To remove, run nixos-clean.sh 1d
                  environment.etc = builtins.listToAttrs (
                    builtins.map (
                      input:
                      lib.attrsets.nameValuePair "sources/${input}" {
                        enable = true;
                        source = inputs.${input};
                        mode = "symlink";
                      }
                    ) (builtins.attrNames inputs)
                  );

                  # Enable CUPS to print documents.
                  # services.printing.enable = true;
                }
              )
            ];
        };
      };
    };
}
