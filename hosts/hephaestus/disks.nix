{
  disks ? ["/dev/vda"],
  zramSwapwritebackSize ? 4,
  physicalSwapSize ? 16,
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
              name = "luks";
              #start = "10GiB";
              size = toString (zramSwapwritebackSize + physicalSwapSize + 1) + "G";
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
            };
              zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = "rpool";
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
            size = toString (zramSwapwritebackSize) + "G";
            name = "zramSwapwritebackDevice";
          };
          physicalSwap = {
            size = toString (physicalSwapSize) + "G";
            name = "swap";
            content = {
              type = "swap";
            };
          };
        };
      };
    };
    zpool = {
      rpool = {
        type = "zpool";
        rootFsOptions = {
          acltype = "posixacl";
          dnodesize = "auto";
          canmount = "off";
          xattr = "sa";
          relatime = "on";
          normalization = "formD";
          mountpoint = "none";
          encryption = "aes-256-gcm";
          keyformat = "passphrase";
          keylocation = "prompt";
          #keylocation = "file:///tmp/pass-zpool-rpool";
          compression = "zstd";
          "com.sun:auto-snapshot" = "false";
        };
        postCreateHook = ''
          zfs set keylocation="prompt" rpool
        '';
        options = {
          ashift = "12";
          autotrim = "on";
        };

        datasets = {
          local = {
            type = "zfs_fs";
            options.mountpoint = "none";
          };
          safe = {
            type = "zfs_fs";
            options.mountpoint = "none";
          };
          "local/reserved" = {
            type = "zfs_fs";
            options = {
              mountpoint = "none";
              reservation = "5GiB";
            };
          };
          "local/root" = {
            type = "zfs_fs";
            mountpoint = "/";
            options.mountpoint = "legacy";
            postCreateHook = ''
              zfs snapshot rpool/local/root@blank
            '';
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options = {
              atime = "off";
              canmount = "on";
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "true";
            };
          };
          # "local/log" = {
          #   type = "zfs_fs";
          #   mountpoint = "/var/log";
          #   options = {
          #     mountpoint = "legacy";
          #     "com.sun:auto-snapshot" = "true";
          #   };
          # };
          "safe/home" = {
            type = "zfs_fs";
            mountpoint = "/home";
            options = {
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "true";
            };
          };
          "safe/persist" = {
            type = "zfs_fs";
            mountpoint = "/persist";
            options = {
              mountpoint = "legacy";
              "com.sun:auto-snapshot" = "true";
            };
          };
        }; # datasets
      }; # rpool
    }; # zpool
  }; # devices
}
