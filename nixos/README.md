Everything here goes into `/etc/nixos` and run `nixos-rebuild switch` to load
the configs.

We are using Nix Flakes here, so remember to put `nix.settings.experimental-features = [ "nix-command" "flakes" ];` in your `/etc/nixos/configuration.nix` file.

> ***DO NOT CHANGE*** `home.stateVersion` unless you know what you're doing.


## Use on fresh installation (/mnt)

* Copy `./disko-config.nix` to `/tmp`.
* Run `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disko-config.nix`.
* Run `nixos-generate-config --no-filesystems --root /mnt`.
* Copy all the contents from this repository directory `./` into `/mnt/etc/nixos`.
* Install OS and the configurations with: `sudo nixos-install --flake /mnt/etc/nixos#nixos`
* Reboot.

or

run `./scripts/execute-fresh-install.sh`


