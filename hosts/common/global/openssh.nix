{
  outputs,
  lib,
  config,
  ...
}: let
  hosts = outputs.nixosConfigurations;
  hostname = config.networking.hostName;
  prefix = "/persist";
  pubKey = host: ../../${host}/ssh_host_ed25519_key.pub;
in {
  services.openssh = {
    enable = true;
    settings = {
      # Harden
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
      # Allow forwarding ports to everywhere
      GatewayPorts = "clientspecified";
    };

    hostKeys = [
      {
        path = "${prefix}/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  programs.ssh = {
    # Each hosts public key
    knownHosts =
      builtins.mapAttrs (name: _: {
        publicKeyFile = pubKey name;
        extraHostNames = lib.optional (name == hostname) "localhost";
      })
      hosts;
  };

  # Passwordless sudo when SSH'ing with keys
  security.pam.enableSSHAgentAuth = true;

  # ensure hostkeys are secure
  systemd.tmpfiles.rules = [
    "d ${prefix}/etc/ssh 0700 root root - -"
    "z ${prefix}/etc/ssh/ssh* 0600 root root - -"
  ];
}
