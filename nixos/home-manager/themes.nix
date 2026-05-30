{
  pkgs,
  ...
}:

let
in
rec {
  gtk = {
    enable = true;
    gtk4.theme = null;
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
}
