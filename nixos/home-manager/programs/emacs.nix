{
  pkgs,
  lib,
  config,
  ...
}:
let
  home = config.home;
in
{
  programs.emacs = {
    enable = true;
    extraPackages =
      epkgs:
      (map (pkg: epkgs.${pkg})) [
        "dash"
        "smex"
        "yaml"
        "nix-mode"
        "yaml-mode"
        "sly"
        "elfeed"
        "vterm"
        "neotree"
        "projectile"
        "projectile-ripgrep"
        "projectile-codesearch"
        "magit"
        "smartparens"
        "nyan-mode"
        "vlf"
        "direnv"
        "company"
        "move-text"
        "restart-emacs"
        "elpher"
        "rustic"
        "haskell-mode"
        "lsp-haskell"
        "flymake"
        "flymake-shellcheck"
        "clang-format"
        "surround"
      ];
    extraConfig = lib.readFile ./emacs/emacs.el;
  };
}
