{
  config,
  pkgs,
  lib,
  desktop,
  ...
}: {
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      swtpm.enable = true;
      ovmf.enable = true;
      ovmf.packages = with pkgs; [OVMFFull.fd];
    };
  };

  # add management packages if we have a desktop set
  environment.systemPackages = lib.mkIf (builtins.isString desktop) [pkgs.virt-manager pkgs.freerdp];

  # easier access to most common ovmf files
  environment.etc = {
    "ovmf/edk2-x86_64-secure-code.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-x86_64-secure-code.fd";
      mode = "0644";
      user = "libvirtd";
    };

    "ovmf/edk2-i386-vars.fd" = {
      source = config.virtualisation.libvirtd.qemu.package + "/share/qemu/edk2-i386-vars.fd";
      mode = "0644";
      user = "libvirtd";
    };
  };
  environment.persistence = {
    "/persist".directories = [
      "/var/lib/libvirt"
    ];
  };
}
