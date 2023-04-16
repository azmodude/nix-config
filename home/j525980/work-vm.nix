{
  inputs,
  pkgs,
  pkgs-stable,
  lib,
  desktop,
  ...
}: {
  imports =
    [
      ../common/global
      ../common/features/cli
      ../common/features/nvim
      ../common/features/sops.nix
    ]
    ++ lib.optional (builtins.isString desktop.environment) ../common/features/desktop/common
    ++ lib.optional (builtins.isString desktop.environment) ../common/features/desktop/${desktop.environment};
}
