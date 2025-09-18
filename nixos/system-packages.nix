{
  pkgs,
  inputs,
  credentials,
  ...
}:
{
  nixpkgs.overlays = [
    inputs.niri.overlays.niri
  ];

  programs = {
    firefox.enable = true;
    fish.enable = true;
    steam.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
    niri.enable = true;
  };

  services = {
    flatpak.enable = true;
    udev.packages = [ pkgs.gnome-settings-daemon ];

    readeck = {
      enable = true;
      environmentFile = "/home/${credentials.userName}/.config/readeck/environment-file";
      settings = {
        server = {
          port = 9090;
        };
      };
    };
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

      # editors
      emacs
      vim # # !!! MUST HAVE FOR EMERGENCY !!!

      # terminal
      libvterm
      libtool
      alacritty
      wezterm
      # for wezterm
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
