{
  credentials,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

let
  minutesToSeconds = minutes: minutes * 60;
in
rec {

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
      publicShare = null;
      templates = null;
    };
  };
  home.preferXdgDirectories = true;
  home.username = credentials.user.name;
  home.homeDirectory = "/home/${credentials.user.name}";

  home.file = {
    # FIXME: Cannot set files with specific permissions.
    # See https://github.com/nix-community/home-manager/issues/3090

    ".emacs" = {
      source = ./data/.emacs;
    };

    ".nanorc" = {
      source = ./data/.nanorc;
    };

    ".quick-emacs.el" = {
      source = ./data/.quick-emacs.el;
    };

    "Pictures/wallpapers" = {
      source = ./data/wallpapers;
      recursive = true;
    };

  };

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

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
      };
    };
  };

  programs.git = {
    enable = true;
    signing = {
      format = "ssh";
      signByDefault = true;
      key = "${home.homeDirectory}/.ssh/id_momo.pub";
    };
    settings = {
      user = {
        name = credentials.user.name;
        email = credentials.user.email;
        init = {
          defaultbranch = "main";
        };
      };
    };
  };

  programs.bat = {
    enable = true;
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      line-numbers = true;
    };
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

  programs.direnv.enable = true;

  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 5000;
    mouse = true;
  };

  programs.alacritty = {
    enable = true;
    theme = "monokai";
    settings = {
      window = {
        opacity = 0.9;
        startup_mode = "Maximized";
        title = "Terminal";
      };

      scrolling = {
        history = 100000;
      };

      selection = {
        save_to_clipboard = true;
      };

      cursor = {
        style = {
          shape = "Block";
          blinking = "On";
        };
      };
    };
  };

  gtk = {
    enable = true;
    colorScheme = "dark";
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };

  # Using the following example configuration, Qt applications
  # will have a look similar to the adwaita style used by GNOME
  # using a dark theme.
  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt6;
    };
  };

  # Try to only add settings that you won't change
  # for a long time or ever again.
  dconf = {
    settings = {
      "org/gnome/mutter" = {
        dynamic-workspaces = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 4;
      };

      "org/gnome/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 (minutesToSeconds 15);
      };

      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-timeout = minutesToSeconds 60;
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
        switch-to-workspace-1 = [ "<Control>F1" ];
        switch-to-workspace-2 = [ "<Control>F2" ];
        switch-to-workspace-3 = [ "<Control>F3" ];
        switch-to-workspace-4 = [ "<Control>F4" ];
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

        favorite-apps = [
          "Alacritty.desktop"
          "btop.desktop"
          "calibre-gui.desktop"
          "org.gnome.Nautilus.desktop"
          "firefox.desktop"
          "dev.zed.Zed.desktop"
          "code.desktop"
          "emacs.desktop"
          "org.keepassxc.KeePassXC.desktop"
          "thunderbird.desktop"
          "audacious.desktop"
          "net.lutris.Lutris.desktop"
          "org.cataclysmdda.CataclysmDDA.desktop"
        ];

        # See ../desktop-environment.nix for extension packages.
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
          "clipboard-indicator@tudmotu.com"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"
          "azwallpaper@azwallpaper.gitlab.com"
          "lockscreen-extension@pratap.fastmail.fm"
        ];
      };

      "org/gnome/shell/extensions/azwallpaper" = {
        slideshow-directory = "${home.homeDirectory}/Pictures/wallpapers";
        slideshow-slide-duration = lib.hm.gvariant.mkTuple [
          0
          7
          0
        ];
      };

      "org/gnome/shell/extensions/lockscreen-extension" = {
        backgrounds-folder-path = "${home.homeDirectory}/Pictures/wallpapers";
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
