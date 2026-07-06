{
  config,
  lib,
  ...
}:
let
  home = config.home;
  minutesToSeconds = minutes: minutes * 60;
  wallpapersPath = "${home.homeDirectory}/Pictures/wallpapers";
in
rec {
  # Try to only add settings that you won't change
  # for a long time or ever again.
  dconf = {
    settings = {
      "org/gnome/mutter" = {
        dynamic-workspaces = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 6;
      };

      "org/gnome/desktop/session" = {
        # Dim screen.
        idle-delay = lib.hm.gvariant.mkUint32 (minutesToSeconds 140);
      };

      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-timeout = minutesToSeconds 180;
        sleep-inactive-ac-type = "suspend";
        sleep-inactive-battery-timeout = minutesToSeconds 30;
        sleep-inactive-battery-type = "suspend";
      };

      "org/gnome/desktop/interface" = {
        accent-color = "green";
      };

      "org/gnome/desktop/interface" = {
        clock-format = "24h";
      };

      "org/gnome/desktop/a11y" = {
        always-show-universal-access-status = true;
      };

      "org/gnome/desktop/interface" = {
        enable-hot-corners = false;
      };

      "org/gnome/desktop/privacy" = {
        remember-recent-files = false;
        remove-old-temp-files = true;
        remove-old-trash-files = true;
      };

      "org/gnome/desktop/wm/keybindings" = {
        switch-to-workspace-1 = [ "<Ctrl>F1" ];
        switch-to-workspace-2 = [ "<Ctrl>F2" ];
        switch-to-workspace-3 = [ "<Ctrl>F3" ];
        switch-to-workspace-4 = [ "<Ctrl>F4" ];
      };

      "org/gnome/desktop/peripherals/mouse" = {
        natural-scroll = false;
      };

      "org/gnome/desktop/peripherals/touchpad" = {
        natural-scroll = false;
        disable-while-typing = false;
        two-finger-scrolling-enabled = true;
      };

      "org/gnome/shell" = {

        # See ../desktop-environment.nix for extension packages.
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "clipboard-indicator@tudmotu.com"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "azwallpaper@azwallpaper.gitlab.com"
          "lockscreen-extension@pratap.fastmail.fm"
          "tiling-assistant@leleat-on-github"
        ];
      };

      "org/gnome/shell/extensions/azwallpaper" = {
        slideshow-directory = wallpapersPath;
        slideshow-slide-duration = lib.hm.gvariant.mkTuple [
          0
          7
          0
        ];
      };

      "org/gnome/shell/extensions/lockscreen-extension" = {
        backgrounds-folder-path = wallpapersPath;
      };
    };
  };
}
