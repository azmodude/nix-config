{
  disks ? ["/dev/vda"],
  swapsize ? "4G",
  ...
}: {
  disko.devices = {
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
                extraFormatArgs = ["--label crypt-system"];
                extraOpenArgs = ["--allow-discards"];
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
    lvm_vg = {
      lvm-crypt-system = {
        type = "lvm_vg";
        lvs = {
          a-swap = {
            type = "lvm_lv";
            size = swapsize;
            name = "swap";
            content = {
              type = "swap";
            };
          };
          b-root = {
            type = "lvm_lv";
            size = "100%FREE";
            name = "root";
            content = {
              type = "btrfs";
              extraArgs = ["-f" "--label btrfs-root"];
              subvolumes = {
                "@" = {
                  mountpoint = "/";
                  mountOptions = ["defaults" "compress=zstd" "noatime"];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = ["defaults" "compress=zstd" "relatime"];
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["defaults" "compress=zstd" "noatime"];
                };
                "@persist" = {
                  mountpoint = "/persist";
                  mountOptions = ["defaults" "compress=zstd" "noatime"];
                };
                "@var-log" = {
                  mountpoint = "/var/log";
                  mountOptions = ["defaults" "compress=zstd" "noatime"];
                };
                "@snapshots" = {
                  mountpoint = "/.snapshots";
                  mountOptions = ["defaults" "compress=zstd" "noatime"];
                };
              };
            };
          };
        };
      };
    };
  };
}
