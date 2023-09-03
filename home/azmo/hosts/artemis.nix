{
  inputs,
  pkgs,
  pkgs-stable,
  user,
  desktop,
  lib,
  ...
}: {
  imports =
    [
      ../../common/global
      ../../common/features/cli
      ../../common/features/nvim
      ../../common/features/sops.nix
      ../../common/features/syncthing.nix
      ../../common/features/desktop/common/libreoffice.nix
    ]
    ++ lib.optional (builtins.isString desktop.environment) ../../common/features/desktop/common
    ++ lib.optional (builtins.isString desktop.environment) ../../common/features/desktop/${desktop.environment};
}
