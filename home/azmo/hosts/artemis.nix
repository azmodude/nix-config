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
      ../../common/features/desktop/hyprland
    ]
    ++ lib.optional (builtins.isString desktop.environment) ../../common/features/desktop/common
    ++ lib.optional (builtins.isString desktop.environment) ../../common/features/desktop/${desktop.environment};

  home.persistence = {
    "/persist/home/${user}" = {
      directories = [
        "Games"
      ];
      allowOther = true;
    };
  };
}
