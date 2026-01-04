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
        "diminish"
        "ivy"
        "counsel"
        "swiper"
        "yaml"
        "nix-mode"
        "yaml-mode"
        "lua-mode"
        "sly"
        "elfeed"
        "vterm"
        "multi-vterm"
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
        "lsp-mode"
        "lsp-ui"
        "lsp-haskell"
        "flymake"
        "flymake-shellcheck"
        "clang-format"
      ];
    extraConfig = lib.readFile ./emacs/emacs.el;
  };
}
