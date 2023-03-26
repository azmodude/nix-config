{disks ? ["/dev/vda"], lib, ...}: {
  disk = {
    disk0 = {
      type = "disk";
      device = builtins.elemAt disks 0;
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            type = "partition";
            name = "ESP";
            start = "1MiB";
            end = "100MiB";
            bootable = true;
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [
                "defaults"
              ];
            };
          }
          {
            type = "partition";
            name = "luks";
            start = "100MiB";
            end = "100%";
            content = {
              type = "luks";
              name = "crypt-system";
              extraOpenArgs = ["--allow-discards"];
              keyFile = lib.optional passphrase;
              content = {
                type = "lvm_pv";
                vg = "lvm-crypt-system";
              };
            };
          }
        ];
      };
    };
  };
  lvm-crypt-system = {
    pool = {
      type = "lvm_vg";
      lvs = {
        swap = {
          type = "lvm_lv";
          size = "2G";
          content = {
            type = "swap";
          };
        };
        root = {
          type = "lvm_lv";
          size = "100%FREE";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
