{config, ...}: let
  hostname = config.networking.hostName;
in {
  boot.initrd = {
    luks.devices."crypt-system".device = "/dev/disk/by-label/crypt-system";
  };
}
