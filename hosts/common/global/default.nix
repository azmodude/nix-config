# This file (and the global directory) holds config that i use on all hosts
{
  lib,
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      inputs.impermanence.nixosModules.impermanence
      inputs.home-manager.nixosModules.home-manager
      #    ./acme.nix
      ./btrbk.nix
      ./editor.nix
      #    ./fish.nix
      ./locale.nix
      #    ./nix.nix
      ./openssh.nix
      ./containers.nix
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

  nix = {
    # weekly nix-store garbage collector, delete anything no longer used older than 30 days
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
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
  boot.tmpOnTmpfs = true;

  systemd = {
    # ensure we making cgroupsv2 the default; e.g. lxd tries to disable it
    enableUnifiedCgroupHierarchy = lib.mkForce true;
    oomd = {
      enable = true;
      enableRootSlice = true;
      enableSystemSlice = true;
      enableUserServices = true;
    };
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };
  powerManagement.enable = true;

  programs.git.enable = true;

  # Increase open file limit for sudoers
  security.pam.loginLimits = [
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
}
