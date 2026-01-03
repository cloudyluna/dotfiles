let
  pkgs = import <nixpkgs> { };
  target = pkgs.firefox;
  endsWith = builtins.match "^.*\.desktop$";
  dir = builtins.readDir "${target}/share/applications";
in
builtins.filter (f: (endsWith f) != null) (builtins.attrNames dir)
