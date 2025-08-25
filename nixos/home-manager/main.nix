{
  credentials,
  config,
  pkgs,
  inputs,
  ...
}:

let
in
rec {

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    xwayland-satellite-stable
    waybar
    fuzzel
    swaynotificationcenter

    # Programming language toolings
    gnuplot_qt

    ### NIX TOOLS
    nixfmt-rfc-style # nix code formatter

    # media
    mpv
    audacious
    gimp3
    yt-dlp
    russ # rss/atom
    syncplay
    gitui

    # git compat
    jujutsu
    taskwarrior3
    taskwarrior-tui

    # database
    sqlite

    # terminal
    alacritty

    # editors
    vscode-fhs

    # shells
    fish
    gh

    # moneh
    gnucash

    # browsers (other than firefox)
    tor-browser

    # office
    libreoffice-qt6-fresh

    # networking tools
    wineWowPackages.stable
    winetricks
  ];

  home.username = credentials.userName;
  home.homeDirectory = "/home/${credentials.userName}";

  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];

  home.sessionVariables = {
    EDITOR = "emacs -Q --no-window-system --load $HOME/.quick-emacs.el";
    GSK_RENDERER = "gl";
  };

  home.shellAliases = {
    "gc" = "git clone";
    "gs" = "git status";
    "gd" = "git diff";
    "list-generations" = "nix profile history --profile /nix/var/nix/profiles/system";
  };

  programs.waybar = {
    enable = true;
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  programs.autojump.enable = true;

  programs.git = {
    enable = true;
    userName = credentials.momoUserName;
    userEmail = credentials.momoUserEmail;
    extraConfig = {
      init = {
        defaultbranch = "main";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "${home.homeDirectory}/.ssh/allowed_signers";
      };
      user.signingkey = "${home.homeDirectory}/.ssh/id_momo.pub";
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
