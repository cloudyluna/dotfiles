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
              haskell.compiler.ghc910
              haskell.packages.ghc910.haskell-language-server
              haskellPackages.cabal-install
              
              ghciwatch
              haskellPackages.fourmolu
              haskellPackages.cabal-gild
            ];
            buildInputs = [
              pkg-config
              upx
              fuse3
            ];

            LD_LIBRARY_PATH = "${lib.makeLibraryPath buildInputs}";
          
        };
      }
    );
}

