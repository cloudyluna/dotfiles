{
  pkgs,
  inputs,
  credentials,
  ...
}:
{
  nixpkgs.overlays = [ ];

  documentation.man.generateCaches = false;

  programs = {
    nix-ld.enable = true;
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
    postgresql = {
      enable = true;
      ensureDatabases = [ "mydatabase" ];
      authentication = pkgs.lib.mkOverride 10 ''
        #type database DBUser auth-method
        local all      all    trust
      '';
    };
    btrfs = {
      autoScrub.enable = true;
    };
    snapper = {
      configs = {
        home = {
          SUBVOLUME = "/home";
          FSTYPE = "btrfs";
          ALLOW_USERS = [ credentials.user.name ];
          TIMELINE_CREATE = false;
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

    # Programming language toolings
    gnuplot_qt
    graphviz

    # media
    imagemagick
    ffmpeg_7
    mpv
    audacious
    yt-dlp
    syncplay
    telegram-desktop
    kiwix
    kiwix-tools

    # database
    sqlite

    # editors
    vscode-fhs
    nixd
    nil

    # shells
    fish

    # browsers (other than firefox)
    tor-browser

    # editors
    emacs
    vim # # !!! MUST HAVE FOR EMERGENCY !!!

    # terminal
    libvterm # for emacs.
    libtool # for emacs.
    alacritty
    luaformatter
    lua

    # sysinfo
    hyfetch
    pciutils
    usbutils
    sysstat
    btop
    efibootmgr

    # archives
    zip
    xz
    unzip
    p7zip
    rar
    zstd

    # utils
    nixfmt-rfc-style
    nixfmt-tree
    cron
    nix-prefetch-scripts
    perf # profile with performance counter
    strace # system call tracer
    lurk # system call tracer (pretty)
    ltrace # library call tracer
    lsof # list open files
    lnav # log file viewer
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    bat # cat with wings
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    shellcheck # A shell linter
    tree # List directory recursively as a tree view
    file # Show file info.
    glow # TUI markdown previewer
    tmux # TTY multiplexer
    xclip # x clipboard
    delta # diff pager
    yazi # TUI file manager
    nh # better nixos manager
    moreutils # collection of utils
    nmap # A utility for network discovery and security auditing
    transmission_4-gtk # torrenting
    curl # fetch
    wget # fetch
    rsync # fetch & cp
    zsync # remote chunking

    # office
    libreoffice-qt6-fresh
    calibre
    thunderbird
    papers # documents viewer

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
    valgrind
    clang
    lldb
    gdb
    gnumake
    cmake
    ccache
    meson
    ninja

    # gaming
    lutris
  ];
}
