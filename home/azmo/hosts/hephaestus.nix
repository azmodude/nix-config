{
  inputs,
  pkgs,
  pkgs-stable,
  desktop,
  lib,
  user,
  ...
}: {
  imports =
    [
      ../../common/global
      ../../common/features/cli
      ../../common/features/nvim
      ../../common/features/sops.nix
      ../../common/features/syncthing.nix
      ../../${user.name}/features/work.nix
      ../../common/features/desktop/common/libreoffice.nix
    ]
    ++ lib.optional (builtins.isString desktop.environment) ../../common/features/desktop/common
    ++ lib.optional (builtins.isString desktop.environment) ../../common/features/desktop/${desktop.environment};
}
