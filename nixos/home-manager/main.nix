{
  inputs,
  pkgs,
  lib,
  credentials,
  config,
  ...
}:

let
in
rec {

  imports = [
    ./themes.nix
    ./dconf.nix
    ./xdg.nix
    ./programs.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [ ];
  home.preferXdgDirectories = true;
  home.username = credentials.user.name;
  home.homeDirectory = "/home/${credentials.user.name}";
  home.file = {
    # FIXME: Cannot set files with specific permissions.
    # See https://github.com/nix-community/home-manager/issues/3090

    ".nanorc" = {
      source = ./data/.nanorc;
    };

    ".rss-bookmarks.json" = {
      source = ./data/.rss-bookmarks.json;
    };

    "Pictures/wallpapers" = {
      source = ./data/wallpapers;
      recursive = true;
    };

    ".emacs" = {
      source = ./data/.emacs.el;
    };
  };
  home.sessionPath = [
    "$HOME/.local/bin"
    "$HOME/.cargo/bin"
  ];
  home.sessionVariables = {
    EDITOR = "emacs --no-window-system";
    GSK_RENDERER = "gl";
  };
  home.shellAliases = {
    "gc" = "git clone";
    "gs" = "git status";
    "ga" = "git add";
    "gdh" = "git diff HEAD";
    "gds" = "git diff --staged";
    "nixos-list-generations" = "nh os info";
    "nixos-cleanup" = "nh clean all --ask --keep 2";
  };

  # FIXME: Cannot find credentials var in a standalone git.nix module.
  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      signByDefault = true;
      # Import both of your private and publish SSH key!
      key = "${home.homeDirectory}/.ssh/id_momo.pub";
    };
    settings = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = credentials.user.name;
        email = credentials.user.email;
      };
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
