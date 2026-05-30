# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./disko-config.nix
  ];

  # Custom hardware configurations.
  hardware.block.scheduler = {
    # See https://wiki.archlinux.org/title/Improving_performance#The_scheduling_algorithms.
    # For HDD.
    "sd[a-z][0-9]*" = "bfq";
  };
  systemd.tmpfiles.settings = {
    # See https://lore.kernel.org/linux-btrfs/051be284-6fe7-4982-a834-e46ce9c124a9@wdc.com/T/#m0e7d1685ca4cada0bac500b04c233ab32bec30d9.
    # With dynamic periodic reclaim, if the system is below 10G unallocated
    # space, then the cleaner thread will identify the best block groups to
    # reclaim to get us back to 10G. It will get progressively more aggressive
    # as unallocated trends towards 0. It will perform no reclaims when
    # unallocated is above 10G.
    #
    # With dynamic periodic reclaim, if the system is below 10G unallocated
    # space, then the cleaner thread will identify the best block groups to
    # reclaim to get us back to 10G. It will get progressively more aggressive
    # as unallocated trends towards 0. It will perform no reclaims when
    # unallocated is above 10G.
    btrfsDataPeriodicDynamicReclaim =
      let
        # TODO: UUID is fixed! Try to reuse from hardware-configuration or disko config.
        dataPath = "/sys/fs/btrfs/a09d6f0a-7f4e-4b76-8fe4-6881656c0902/allocation/data";
        fileOptions = {
          w = {
            group = "root";
            user = "root";
            argument = "1";
          };
        };
      in
      {
        "${dataPath}/periodic_reclaim" = {
          inherit (fileOptions) w;
        };
        "${dataPath}/dynamic_reclaim" = {
          inherit (fileOptions) w;
        };
      };
  };

  # Bootloader.

  ## systemd-boot
  boot.loader.systemd-boot = {
    enable = true;
    consoleMode = "max";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;
  boot.kernelParams = [
    "zswap.enabled=1"
    "zswap.accept_threshold_percent=90"
    "zswap.compressor=zstd" # compression algorithm
    "zswap.max_pool_percent=50" # maximum percentage of RAM that zswap is allowed to use
    "zswap.shrinker_enabled=1" # whether to shrink the pool proactively on high memory pressure
    "zswap.zpool=zsmalloc"

    "boot.shell_on_fail"
  ];

  # Enable the Flakes feature and the accompanying new nix command-line tool
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.trusted-users = [
    "root"
    "momo"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
