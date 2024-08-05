{ config, pkgs, ... }:

let
  credentials = import ./pub_credentials.nix;
in
rec {

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # Programming language toolings

    octaveFull

    # racket
    racket

    ### NIX TOOLS
    nixfmt-rfc-style # nix code formatter

    # dhall
    dhall
    dhall-nix
    dhall-json
    dhall-docs

    ### NIX TOOLS

    ## proof assistants
    lean4
    coq

    # rust
    rust-bin.stable.latest.default

    # haskell
    cabal-install
    ghc
    ghcid

    # media
    okular
    syncplay
    mpv
    audacious
    gimp
    krita
    yt-dlp
    tiled

    # docs
    pandoc

    # database
    sqlite
    konsole

    # editors
    vscode-fhs

    # shells
    fish

    # browsers (other than firefox)
    tor-browser

    # office
    libreoffice-qt6-fresh
    texstudio
    texliveFull

    # networking tools

    # games
    minetest
    lutris
    wineWowPackages.stable
    winetricks
  ];

  home.username = credentials.userName;
  home.homeDirectory = "/home/${credentials.userName}";

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.shellAliases = {
    "gc" = "git clone";
    "gs" = "git status";
    "gd" = "git diff";
    "list-generations" = "nix profile history --profile /nix/var/nix/profiles/system";
  };

  programs.ssh = {
    enable = true;
  };

  services.gnome-keyring.enable = true;
  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  programs.autojump.enable = true;

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = credentials.userName;
    userEmail = credentials.userEmail;
    signing = {
      key = credentials.gpgFingerprint;
      signByDefault = true;
    };
    extraConfig = {
      init = {
        defaultbranch = "main";
      };
    };
  };

  # Install direnv and enable for development.
  programs.direnv = {
    enable = true;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.fish = {
    enable = true;
    # Don't do that shell init greetings ever again!
    interactiveShellInit = "set fish_greeting";
  };

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs; [
      { package = gnomeExtensions.tiling-assistant; }
      { package = gnomeExtensions.clipboard-history; }
    ];
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
