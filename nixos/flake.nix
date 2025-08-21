{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      nixpkgs,
      flake-utils,
      home-manager,
      ...
    }:
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules =
            let
              credentials = import ./pub_credentials.nix;

            in
            [
              ./configuration.nix
              home-manager.nixosModules.default
              {
                # HOME MANAGER
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.backupFileExtension = "backup";
                home-manager.users.${credentials.userName} = import ./home.nix;
              }

              (
                { pkgs, lib, ... }:
                {
                  ################################## Configs ########################################
                  programs.ssh.startAgent = true;

                  # Enable zRAM for better memory performance.
                  zramSwap.enable = true;
                  programs.steam.enable = true;

                  fonts.packages = with pkgs; [
                    fira-code
                    fira-math
                  ];

                  programs.appimage = {
                    enable = true;
                    binfmt = true;
                  };

                  # niri - a tilling window manager
                  programs.niri.enable = true;

                  # Enable fish shell.
                  programs.fish.enable = true;

                  # Define a user account. Don't forget to set a password with ‘passwd’.
                  users.users.${credentials.userName} = {
                    shell = pkgs.fish;
                    isNormalUser = true;
                    description = credentials.description;
                    extraGroups = [
                      "networkmanager"
                      "wheel"
                    ];
                    #packages = with pkgs; [];
                  };

                  networking.hostName = credentials.hostName;

                  # Allow unfree packages
                  nixpkgs.config.allowUnfree = true;

                  # Install & enable firefox.
                  programs.firefox.enable = true;

                  # Install flatpak & enable flatpak.
                  services.flatpak.enable = true;

                  nixpkgs.overlays = [
                    # We use community maintained rust toolchains.
                  ];

                  ################################## Configs ########################################

                  # Keep flake sources that are present with unremoved generations.
                  # To remove, run nixos-clean.sh 1d
                  environment.etc = builtins.listToAttrs (
                    builtins.map (
                      input:
                      lib.attrsets.nameValuePair "sources/${input}" {
                        enable = true;
                        source = inputs.${input};
                        mode = "symlink";
                      }
                    ) (builtins.attrNames inputs)
                  );

                  environment.sessionVariables.NIXOS_OZONE_WL = "1";
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
              )
            ];
        };
      };
    };
}
