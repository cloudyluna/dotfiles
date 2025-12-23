{ pkgs, ... }@inputs:
{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Wayland compatibility
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # Display manager
  services.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "gnome";

  # GNOME
  services.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;
  services.gnome.gcr-ssh-agent.enable = false; # See https://github.com/NixOS/nixpkgs/issues/466769
  # Instead, we explicitly start SSH agent. The authorization
  # can be retained by doing ssh-add <SSH_KEY> in the CLI.
  programs.ssh.startAgent = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
    gnome-music
    gnome-maps
    gnome-software
  ];

  environment.systemPackages = with pkgs.gnomeExtensions; [
    appindicator
    clipboard-indicator
    removable-drive-menu
    wallpaper-slideshow
    lockscreen-extension
  ];
}
