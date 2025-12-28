{
  pkgs,
  config,
  ...
}:
let
  home = config.home;
in
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
    ];
    extraPackages = with pkgs; [
      nixd
    ];
    userSettings = {
      enable_ai = false;
      telemetry = {
        metrics = false;
      };
    };
  };
}
