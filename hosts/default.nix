{
  desktop,
  hostname,
  lib,
  modulesPath,
  pkgs,
  user,
  ...
}: {
  # Import host specific boot and hardware configurations.
  imports = [
    #    (./. + "/${hostname}/boot.nix")
    (./. + "/${hostname}")
    ./common/global
    ./common/users
    ./common/users/root
    ./common/users/${user.name}
    #    ./_mixins/base
    #    ./_mixins/boxes
    #    ./_mixins/users/root
    #    ./_mixins/users/${username}
  ];

  users.mutableUsers = false;

  # use nvd to report changes after activation
  system.activationScripts.diff = {
    supportsDryActivation = true;
    text = ''
      echo
      ${pkgs.nvd}/bin/nvd --nix-bin-dir=${pkgs.nix}/bin diff /run/current-system "$systemConfig"
      echo
    '';
  };
}
