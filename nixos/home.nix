{ config, pkgs, ... }:

let
  credentials = import ./pub_credentials.nix;
in
rec {

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # Programming language toolings
    octave

    ### NIX TOOLS
    nixfmt-rfc-style # nix code formatter

    ### NIX TOOLS

    # media
    okular
    mpv
    audacious
    gimp
    yt-dlp
    russ # rss/atom

    # docs
    pandoc

    # database
    sqlite

    # terminal
    konsole
    alacritty

    # editors
    vscode-fhs

    # shells
    fish

    # browsers (other than firefox)
    tor-browser

    # office
    libreoffice-qt6-fresh

    # networking tools

    # games
    wineWowPackages.stable
    winetricks
  ];

  home.username = credentials.userName;
  home.homeDirectory = "/home/${credentials.userName}";

  home.sessionPath = [ "$HOME/.local/bin" ];

  home.sessionVariables = {
    EDITOR = "emacs -nw";
  };

  home.shellAliases = {
    "gc" = "git clone";
    "gs" = "git status";
    "gd" = "git diff";
    "list-generations" = "nix profile history --profile /nix/var/nix/profiles/system";
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.gpg.enable = true;
  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-qt;
    enableSshSupport = true;
    defaultCacheTtl = 34560000;
    maxCacheTtl = 34560000;
    defaultCacheTtlSsh = 10800;
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
    interactiveShellInit = ''
      # Don't do that shell init greetings ever again!
      set fish_greeting
    '';
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
