{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./global
    ./features/cli
    ./features/desktop/common
    ./features/desktop/gnome
    ./features/nvim
    ./features/emacs
    ./features/sops.nix
  ];
}
