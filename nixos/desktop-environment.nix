{ pkgs, ... }@inputs:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Configure keymap in X11
  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  # PLASMA
  services.displayManager.sddm.enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    oxygen
  ];

  # GNOME
  services.xserver.desktopManager.gnome.enable = true;
  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;
  services.gnome.games.enable = false;
  environment.gnome.excludePackages = with pkgs; [
    gnome-tour
    gnome-user-docs
  ];
}
