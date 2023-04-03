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
    ../common/features/desktop/gnome
    ../common/features/nvim
    ../common/features/emacs
    ../common/features/sops.nix
  ];
}
