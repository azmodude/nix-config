{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./_1password.nix
    ./cups.nix
    ./flatpak.nix
    ./fonts.nix
    ./pipewire.nix
    ./wayland.nix
    ./xdg.nix
  ];
  networking.networkmanager = {
    enable = true;
  };
  # work around bug https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce false;

  services.udev.packages = [pkgs.yubikey-personalization];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
