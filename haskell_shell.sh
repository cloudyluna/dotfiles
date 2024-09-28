#!/usr/bin/env bash

nix shell  \
    -I nixpkgs=https://github.com/NixOS/nixpkgs/archive/d3f42bd62aa840084563e3b93e4eab73cb0a0448.tar.gz \
    nixpkgs/nixos-unstable#haskellPackages.cabal-install \
    nixpkgs/nixos-unstable#haskell.compiler.ghc910 \
    nixpkgs/nixos-unstable#haskellPackages.ghcid \
    nixpkgs/nixos-unstable#haskellPackages.fourmolu \
    nixpkgs/nixos-unstable#haskellPackages.hlint
