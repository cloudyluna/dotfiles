{
  pkgs,
  inputs,
  credentials,
  ...
}:
{
  nixpkgs.overlays = [ ];

  programs = {
    fish.enable = true;
    firefox.enable = true;
    autojump.enable = true;
    direnv.enable = true;
    steam.enable = true;
    appimage = {
      enable = true;
      binfmt = true;
    };
  };

  services = {
    flatpak.enable = true;
    udev.packages = [ pkgs.gnome-settings-daemon ];
    snapper = {
      configs = {
        home = {
          SUBVOLUME = "/home";
          FSTYPE = "btrfs";
          ALLOW_USERS = [ credentials.user.name ];
          TIMELINE_CREATE = true;
          TIMELINE_CLEANUP = false;
          TIMELINE_LIMIT_DAILY = 0;
          TIMELINE_LIMIT_WEEKLY = 0;
          TIMELINE_LIMIT_MONTHLY = 0;
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    snapper
    disko
    nh
    moreutils

    # Programming language toolings
    gnuplot_qt
    graphviz

    # media
    eog
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
    zed-editor-fhs

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
    zstd

    # utils
    nixfmt-rfc-style
    cron
    nix-prefetch
    nix-prefetch-git
    nix-prefetch-hg
    nix-prefetch-bzr
    nix-prefetch-github
    xsel
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    bat # cat with wings
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    shellcheck # Shell linter
    tree # List directory recursively as a tree view
    file # Show file info.
    glow # TUI markdown previewer
    tmux # TTY multiplexer
    xclip
    delta

    # networking tools
    nmap # A utility for network discovery and security auditing
    transmission_4-gtk

    curl # fetch
    wget
    rsync
    zsync

    # office
    libreoffice-qt6-fresh
    calibre
    evince
    thunderbird

    # passwords security
    keepassxc
    gnupg

    # emergency browsers
    lynx
    elinks

    # devel
    openssl
    pkg-config
    git
    gdb
    valgrind
    clang
    gnumake
    cmake
    ccache
    meson
    ninja

    # gaming
    lutris
    cataclysm-dda
  ];
}
