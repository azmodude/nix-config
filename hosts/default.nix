{
  desktop,
  hostname,
  lib,
  modulesPath,
  pkgs,
  username,
  ...
}: {
  # Import host specific boot and hardware configurations.
  imports = [
    #    (./. + "/${hostname}/boot.nix")
    (./. + "/${hostname}")
    ./common/global
    #    ./_mixins/base
    #    ./_mixins/boxes
    #    ./_mixins/users/root
    #    ./_mixins/users/${username}
  ];
}
