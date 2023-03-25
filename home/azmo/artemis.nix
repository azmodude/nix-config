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
    ./features/gaming
    ./features/nvim
    ./features/emacs
    ./features/sops.nix
    ./features/syncthing.nix
  ];
}
