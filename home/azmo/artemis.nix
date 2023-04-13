{
  inputs,
  pkgs,
  pkgs-stable,
  user,
  ...
}: {
  imports = [
    ../common/global
    ../common/features/cli
    ../common/features/desktop/common
    ../common/features/desktop/common/libreoffice.nix
    ../common/features/desktop/gnome
    ../common/features/nvim
    ../common/features/sops.nix
    ../common/features/syncthing.nix
  ];
  home.persistence = {
    "/persist/home/${user}" = {
      directories = [
        "Games"
      ];
      allowOther = true;
    };
  };
}
