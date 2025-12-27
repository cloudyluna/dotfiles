{
  description = "A top down game";

  inputs = {
    nixpkgs.url      = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url  = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in
        {
          devShells.default = with pkgs; pkgs.mkShell rec {
            nativeBuildInputs = [
              haskell.compiler.ghc914
              haskellPackages.cabal-install
              
              ghciwatch
              haskellPackages.fourmolu
              haskellPackages.cabal-gild
              
              sqlite
            ];
            buildInputs = [
              pkg-config
              upx
              zlib
            ];

            LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
          
        };
      }
    );
}

