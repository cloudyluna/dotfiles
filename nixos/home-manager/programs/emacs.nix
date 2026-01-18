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
        "vterm"
        "multi-vterm"
        "treemacs"
        "projectile"
        "projectile-ripgrep"
        "treemacs-projectile"
        "treemacs-magit"
        "magit"
        "smartparens"
        "nyan-mode"
        "vlf"
        "direnv"
        "company"
        "move-text"
        "restart-emacs"
        "rustic"
        "haskell-mode"
        "ultra-scroll"
        "lsp-mode"
        "lsp-ui"
        "lsp-haskell"
        "flymake"
        "flymake-shellcheck"
        "monokai-pro-theme"
        "org-roam"
        "ox-gfm"
      ];
    extraConfig = lib.readFile ./emacs/emacs.el;
  };
}
