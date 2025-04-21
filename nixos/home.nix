{ config, pkgs, ... }:

let
  credentials = import ./pub_credentials.nix;
in
rec {

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    # Programming language toolings
    octaveFull
    gnuplot_qt

    ### NIX TOOLS
    nixfmt-rfc-style # nix code formatter

    ### NIX TOOLS
    shake
    # media
    okular
    mpv
    audacious
    gimp
    kdePackages.kclock
    yt-dlp
    russ # rss/atom
    syncplay
    gitui

    # docs
    pandoc

    # git compat
    mutt
    jj
    taskwarrior3
    taskwarrior-tui

    # database
    sqlite

    # terminal
    konsole
    alacritty

    # editors
    vscode-fhs

    # shells
    fish

    # moneh
    gnucash

    # browsers (other than firefox)
    tor-browser

    # office
    libreoffice-qt6-fresh
    drawio

    # networking tools
    wineWowPackages.stable
    winetricks
  ];

  home.username = credentials.userName;
  home.homeDirectory = "/home/${credentials.userName}";

  home.sessionPath = [
    "${home.homeDirectory}/.local/bin"
    "${home.homeDirectory}/.cargo/bin"
  ];

  home.sessionVariables = {
    EDITOR = "emacs --quick --no-window-system --load $HOME/.quick-emacs.el";
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

  programs.autojump.enable = true;

  programs.git = {
    enable = true;
    userName = credentials.userName;
    userEmail = credentials.userEmail;
    extraConfig = {
      init = {
        defaultbranch = "main";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "${home.homeDirectory}/.ssh/allowed_signers";
      };
      user.signingkey = "${home.homeDirectory}/.ssh/id_ed25519.pub";
      commit.gpgsign = true;
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
  home.stateVersion = "24.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
