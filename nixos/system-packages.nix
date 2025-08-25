{ pkgs, inputs, ... }:
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
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.

    # programming language toolings
    # python3: do I need this? For some reason, having python in PATH in my previous OSes
    # will always slow things down.
    # ehh, just `nix shell nixpkgs#python3` if I ever need it.
    moreutils

    # editors
    emacs
    libvterm
    cmake
    libtool
    vim

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
    cron
    yazi # TUI file manager
    nix-prefetch
    nix-prefetch-git
    nix-prefetch-hg
    nix-prefetch-bzr
    nix-prefetch-github
    xsel
    valgrind
    gdb
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
    transmission_4
    transmission_4-gtk
    xclip

    # networking tools
    nmap # A utility for network discovery and security auditing

    curl # fetch
    wget
    rsync

    # passwords security
    keepassxc
    gnupg

    # emergency browser
    lynx

    # devel
    openssl # do I need this at global level?
    pkg-config # do I need this at global level?
    git
    libgcc
    gnumake
    ccache
  ];
}
