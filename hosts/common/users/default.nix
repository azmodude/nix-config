{config, ...}: let
  userimports = {work-vm = [./j525980 ./root];};
in {
  imports =
    if (builtins.hasAttr config.networking.hostName userimports)
    then (builtins.getAttr userimports)
    else [./azmo ./root];
  users.mutableUsers = false;
}
