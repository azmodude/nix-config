{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports =
    [
      inputs.sops-nix.homeManagerModules.sops
      inputs.impermanence.nixosModules.home-manager.impermanence
      ./packages.nix

      # If you want to use modules your own flake exports (from modules/home-manager):
      # outputs.homeManagerModules.example

      # Or modules exported from other flakes (such as nix-colors):
      # inputs.nix-colors.homeManagerModules.default

      # You can also split up your configuration and import pieces of it here:
      # ./nvim.nix
    ]
    ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
      outputs.overlays.additions

      # You can also add overlays exported from other flakes:
      inputs.neovim-nightly-overlay.overlay

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
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
    };
  };

  # Enable home-manager and git
  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  home = {
    username = lib.mkDefault "azmo";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    stateVersion = lib.mkDefault "22.11";

    persistence = {
      "/persist/home/azmo" = {
        directories = [
          "Documents"
          "Downloads"
          "Pictures"
          "Videos"
          ".config/1Password"
        ];
        allowOther = true;
      };
    };
  };
  # ensure misc directories exist and/or are secure
  systemd.user.tmpfiles.rules = [
    "z /home/azmo/.config/1Password 0700 azmo azmo - -"
    "Z /home/azmo/.config/sops 0700 azmo azmo - -"
    "z /home/azmo/.config/sops/age/keys.txt 0600 azmo azmo - -"
  ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
