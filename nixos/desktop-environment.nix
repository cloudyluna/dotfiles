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
  services.xserver.displayManager.gdm.enable = true;
  services.displayManager.defaultSession = "gnome";

  # GNOME
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = true;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];

  # Using the following example configuration, Qt applications
  # will have a look similar to the adwaita style used by GNOME
  # using a dark theme.
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
