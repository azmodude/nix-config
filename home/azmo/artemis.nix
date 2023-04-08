{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ../common/global
    ../common/features/cli
    ../common/features/desktop/common
    ../common/features/desktop/common/libreoffice.nix
    ../common/features/desktop/gnome
    ../common/features/gaming
    ../common/features/nvim
    ../common/features/sops.nix
    ../common/features/syncthing.nix
  ];
}
