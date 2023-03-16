{pkgs, ...}: {
  imports = [
    ./_1password.nix
    ./cups.nix
    ./flatpak.nix
    ./fonts.nix
    ./pipewire.nix
    ./wayland.nix
  ];
  networking.networkmanager.enable = true;

  services.udev.packages = [pkgs.yubikey-personalization];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
