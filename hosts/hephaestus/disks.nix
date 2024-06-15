{
  disks ? ["/dev/nvme0n1"],
  zramSwapwritebackSize ? "4G",
  physicalSwapSize ? "16G",
  ...
}: {
  disko.devices = {
    disk = {
      disk0 = {
        type = "disk";
        device = builtins.elemAt disks 0;
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1MiB";
              end = "10GiB";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                extraArgs = ["-n ESP"];
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                  "umask=0077"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypt-system";
                extraFormatArgs = ["--label crypt-system"];
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "lvm_pv";
                  vg = "lvm-crypt-system";
                };
              };
            };
          };
        };
      };
    };
    lvm_vg = {
      lvm-crypt-system = {
        type = "lvm_vg";
        lvs = {
          zramSwapwriteBackDevice = {
            priority = 1;
            size = zramSwapwritebackSize;
            name = "zramSwapwritebackDevice";
          };
          physicalSwap = {
            priority = 2;
            size = physicalSwapSize;
            name = "swap";
            content = {
              type = "swap";
            };
          };
          root = {
            priority = 3;
            size = "100%FREE";
            name = "root";
            content = {
              type = "btrfs";
              extraArgs = ["-f" "--label btrfs-root"];
               postCreateHook = ''
                MNTPOINT=$(mktemp -d)
                mount "/dev/disk/by-label/btrfs-root" "$MNTPOINT" -o subvolid=5
                trap 'umount $MNTPOINT; rm -rf $MNTPOINT' EXIT
                btrfs subvolume snapshot -r $MNTPOINT/system/@ $MNTPOINT/system/@-blank
              '';
              subvolumes = {
                "system" = {};
                "system/@" = {
                  mountpoint = "/";
                  mountOptions = ["defaults" "compress=zstd" "noatime"];
                };
                "system/@snapshots" = {
                  mountpoint = "/.snapshots";
                  mountOptions = ["defaults" "compress=zstd" "noatime"];
                };
                "system/@nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["defaults" "compress=zstd" "noatime"];
                };
                "system/@var-log" = {
                  mountpoint = "/var/log";
                  mountOptions = ["defaults" "compress=zstd" "noatime"];
                };
                "data" = {};
                "data/@home" = {
                  mountpoint = "/home";
                  mountOptions = ["defaults" "compress=zstd" "relatime"];
                };
                "data/@persist" = {
                  mountpoint = "/persist";
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
