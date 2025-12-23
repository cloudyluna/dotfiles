{
  description = ''
    Main NixOS configuration
  '';

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-utils.url = "github:numtide/flake-utils";
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      disko,
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
                lib = pkgs.lib;
                pkgs = pkgs;
                credentials = publicCredentials;
                home-manager = home-manager;
                inputs = inputs;
                config = pkgs.config;
              };
            in
            [
              ./configuration.nix
              disko.nixosModules.disko
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

                  # https://github.com/NixOS/nixpkgs/issues/149812
                  environment.extraInit = ''
                    export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
                  '';

                  # Enable CUPS to print documents.
                  # services.printing.enable = true;
                }
              )
            ];
        };
      };
    };
}
