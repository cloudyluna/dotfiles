Everything here goes into `/etc/nixos` and run `nixos-rebuild switch` to load
the configs.

We are using Nix Flakes here, so remember to put `nix.settings.experimental-features = [ "nix-command" "flakes" ];` in your `/etc/nixos/configuration.nix` file.
