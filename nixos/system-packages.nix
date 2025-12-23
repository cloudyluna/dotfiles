{
  pkgs,
  inputs,
  credentials,
  ...
}:
{
  nixpkgs.overlays = [
  ];

  programs = {
    firefox.enable = true;
    autojump.enable = true;
    direnv.enable = true;
    fish = {
      enable = true;
      interactiveShellInit = ''
        # Don't do that shell init greetings ever again!
        set fish_greeting
      '';
    };
    steam.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  services = {
    flatpak.enable = true;
    udev.packages = [ pkgs.gnome-settings-daemon ];
  };

  environment.systemPackages =
    with pkgs;
    let
      myGnomeExtensions = with pkgs.gnomeExtensions; [
        appindicator
        pano # clipboard
      ];
      myKDEPackages = with pkgs.kdePackages; [
        konsole
      ];
    in
    [
      moreutils

      # Programming language toolings
      gnuplot_qt

      # media
      mpv
      audacious
      gimp3
      yt-dlp
      syncplay
      gitui

      # git compat
      taskwarrior3
      taskwarrior-tui

      # database
      sqlite

      # editors
      vscode-fhs

      # shells
      fish

      # browsers (other than firefox)
      tor-browser

      # WINE tools
      wineWowPackages.stable
      winetricks

      # editors
      emacs
      vim # # !!! MUST HAVE FOR EMERGENCY !!!

      # terminal
      libvterm
      libtool
      alacritty
      luaformatter
      lua

      # Also check /etc/nixos/home.nix for more user env packages.

      # sysinfo
      neofetch
      pciutils
      usbutils
      sysstat
      btop

      # archives
      zip
      xz
      unzip
      p7zip
      rar
      unrar
      zstd

      # utils
      nixfmt-rfc-style
      cron
      yazi # TUI file manager
      nix-prefetch
      nix-prefetch-git
      nix-prefetch-hg
      nix-prefetch-bzr
      nix-prefetch-github
      xsel
      pinentry-qt
      pinentry-curses
      ripgrep # recursively searches directories for a regex pattern
      jq # A lightweight and flexible command-line JSON processor
      eza # A modern replacement for ‘ls’
      fzf # A command-line fuzzy finder
      shellcheck # Shell linter
      tree # List directory recursively as a tree view
      file # Show file info.
      glow # TUI markdown previewer
      tmux # TTY multiplexer
      xclip

      # networking tools
      nmap # A utility for network discovery and security auditing

      curl # fetch
      wget
      rsync
      zsync

      # office
      libreoffice-qt6-fresh

      # passwords security
      keepassxc
      gnupg

      # emergency browser
      lynx

      # devel
      openssl
      pkg-config
      git
      gdb
      valgrind
      libgcc
      gnumake
      cmake
      ccache
      meson
      ninja

      # gaming
      lutris
    ]
    ++ myGnomeExtensions
    ++ myKDEPackages;
}
