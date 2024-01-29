# This file (and the global directory) holds config that i use on all hosts
{
  config,
  lib,
  inputs,
  pkgs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.impermanence.nixosModules.impermanence
      inputs.home-manager.nixosModules.home-manager
      #    ./acme.nix
      ./auto-upgrade.nix
      ./boot.nix
      ./editor.nix
      ./hardware.nix
      #    ./fish.nix
      ./locale.nix
      ./nix.nix
      ./openssh.nix
      ./containers.nix
      ./networking.nix
      #    ./postgres.nix
      ./shells.nix
      ./sops.nix
      #    ./ssh-serve-store.nix
      #    ./steam-hardware.nix
      ./systemd-resolved.nix
      ./tailscale.nix
    ]
    ++ (builtins.attrValues outputs.nixosModules);

  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs outputs;};
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.additions

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  environment = {
    persistence = {
      "/persist".directories = ["/var/lib/systemd" "/srv"];
    };
    enableAllTerminfo = true;
  };

  programs.fuse.userAllowOther = true;
  hardware.enableRedistributableFirmware = true;
  #  networking.domain = "m7.rs";
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.tmp = {
    useTmpfs = true;
    cleanOnBoot = true;
  };

  systemd = {
    # ensure we making cgroupsv2 the default; e.g. lxd tries to disable it
    enableUnifiedCgroupHierarchy = lib.mkForce true;
    oomd = {
      enable = true;
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserSlices = true;
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
  powerManagement.enable = true;

  programs.git.enable = true;

  console = {
    earlySetup = true;
    font = "ter-powerline-v18n";
    packages = [pkgs.terminus_font pkgs.powerline-fonts];
    keyMap = "de";
  };

  # Increase open file limit for sudoers
  security = {
    sudo = {
      enable = true;
      wheelNeedsPassword = true;
    };
    pam.loginLimits = [
      {
        domain = "@wheel";
        item = "nofile";
        type = "soft";
        value = "524288";
      }
      {
        domain = "@wheel";
        item = "nofile";
        type = "hard";
        value = "1048576";
      }
    ];
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";
}
