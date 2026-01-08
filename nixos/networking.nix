inputs@{ credentials, ... }:
{
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable networking
  networking = {
    networkmanager = {
      enable = true;
      settings = {
        connection = {
          # If unspecified, the ultimate default values depends on the
          # DNS plugin. With systemd-resolved the default currently is
          # its global setting and for all other plugins "no" (0).
          #
          # Set this to 0 for services.resolved to work properly.
          dns-over-tls = 0;
        };
      };
    };
    hostName = credentials.host.name;
  };
  services.resolved = {
    enable = true;
    # Always encrypts DNS lookups.
    # WARNING: Set this to "false" if we want to access captive
    # portals as there may be issues.
    dnsovertls = "true";
    domains = [ "~." ];
    extraConfig = ''
      DNS=1.1.1.1#one.one.one.one 1.0.0.1#one.one.one.one 2606:4700:4700::1111#one.one.one.one 2606:4700:4700::1001#one.one.one.one
    '';
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH server daemon.
  # services.openssh.enable = true;
}
