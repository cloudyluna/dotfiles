{ pkgs ? import <nixpkgs> {} }:

(pkgs.buildFHSEnv {
  name = "simple-x11-env";
  targetPkgs = pkgs: (with pkgs; [
    zlib
    libpng
    udev
    SDL
    libGL
    libGLU
    #nodejs_22
    alsa-lib
    upx
    SDL2
    SDL2_image
    SDL2_mixer
    SDL2_ttf
    nss
    gmp
    ncurses
    glib
    nspr
    atk
    gtk3
    gtk4
    cups
    dbus
    libdrm
    pango
    cairo
    gdk-pixbuf
    expat
    mesa
    libxkbcommon
    wayland
    vulkan-loader
  ]) ++ (with pkgs.xorg; [
    libX11
    libXcursor
    libXrandr
    libXcomposite
    libXdamage
    libXScrnSaver
    libXxf86vm
    libXext
    libXfixes
    libXrandr
    libxcb
    libXinerama
    libXi
  ]);
  multiPkgs = pkgs: (with pkgs; [
    udev
    alsa-lib
  ]);
  runScript = "bash";
}).env
