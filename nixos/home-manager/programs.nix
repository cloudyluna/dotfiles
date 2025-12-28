{
  pkgs,
  lib,
  credentials,
  config,
  ...
}:

let
  home = config.home;
in
rec {
  imports = [
    ./programs/zellij.nix
    ./programs/alacritty.nix
    ./programs/zed-editor.nix
  ];

  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks = {
        "*" = {
          addKeysToAgent = "yes";
        };
      };
    };

    bat = {
      enable = true;
    };

    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        line-numbers = true;
      };
    };

    bash = {
      enable = true;
      enableCompletion = true;
    };

    fish = {
      enable = true;
      interactiveShellInit = ''
        # Don't do that shell init greetings ever again!
        set fish_greeting
      '';
    };

    direnv.enable = true;
    autojump.enable = true;
    yazi.enable = true;
    lazygit = {
      enable = true;
      settings = {
        git = {
          autoFetch = false;
          autoRefresh = false;
        };
      };
    };
  };
}
