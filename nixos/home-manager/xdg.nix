{
  pkgs,
  config,
  ...
}:
let
  home = config.home;
in
rec {
    xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      publicShare = null;
      templates = null;
    };
    autostart = {
      enable = true;
      entries = [
        "${pkgs.audacious}/share/applications/audacious.desktop"
      ];
    };
    desktopEntries = {
      # Alacritty top level name should be PascalCase
      # to override existing desktop file.
      Alacritty =
        let
          zellijExec = "alacritty -e zellij --layout ${home.homeDirectory}/.config/zellij/layouts/dev.kdl";
        in
        {
          name = "Alacritty";
          type = "Application";
          genericName = "Terminal";
          exec = zellijExec;
          terminal = false;
          startupNotify = true;
          categories = [
            "System"
            "TerminalEmulator"
          ];
          icon = "Alacritty";
          comment = "A fast, cross-platform, OpenGL terminal emulator";

          actions = {
            "new-terminal" = {
              name = "New Terminal Without Zellij";
              exec = "alacritty";
            };
            "new-terminal-zellij" = {
              name = "New Terminal With Zellij";
              exec = zellijExec;
            };
          };
        };
    };
  };
}
