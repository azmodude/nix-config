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
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
