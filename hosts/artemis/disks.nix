{
  disks ? ["/dev/nvme0n1"],
  swapsize ? "16G",
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
              name = "ESP";
              start = "1MiB";
              end = "10GiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                extraArgs = ["-n ESP"];
                mountpoint = "/boot";
                mountOptions = [
                  "defaults"
                ];
              };
            }
            {
              name = "luks";
              start = "10GiB";
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
            size = swapsize;
            name = "swap";
            content = {
              type = "swap";
            };
          };
          b-root = {
            size = "100%FREE";
            name = "root";
            content = {
              type = "btrfs";
              extraArgs = ["-f" "--label btrfs-root"];
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
                "data/@persist/games" = {
                  mountpoint = "/persist/games";
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
