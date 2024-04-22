{
  description = "azmo's flake, based on Misterio77's (https://github.com/Misterio77) awesome nix-starter-configs and nix-config repositories.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # declarative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # additional hardware declarations
    hardware.url = "github:nixos/nixos-hardware";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # pre-commit awesomeness
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";

    # persistance (or not)
    impermanence.url = "github:nix-community/impermanence";

    # nightly neovim awesomeness
    #neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    # weekly nix-index database for nix-locate
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # secret management
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    disko,
    home-manager,
    nixpkgs,
    nixpkgs-unstable,
    pre-commit-hooks,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
  in rec {
    # Your custom packages
    # Acessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./pkgs {inherit pkgs;}
    );
    # Devshell for bootstrapping
    # Acessible through 'nix develop' or 'nix-shell' (legacy)
    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs-unstable.legacyPackages.${system};
        checks = {
          pre-commit-check = pre-commit-hooks.lib.${system}.run {
            src = ./.;
            hooks = {
              alejandra.enable = true;
              convco.enable = true;
              gitleaks = {
                enable = true;
                name = "gitleaks";
                description = "Run gitleaks to check for credentials";
                entry = "${pkgs.gitleaks}/bin/gitleaks protect --verbose --redact --staged";
              };
              # ggshield = {
              #   enable = true;
              #   name = "ggshield";
              #   description = "Run ggshield to check for credentials";
              #   entry = "${pkgs.ggshield.overrideAttrs {
              #     doCheck = false;
              #     doInstallCheck = false;
              #   }}/bin/ggshield secret scan pre-commit";
              # };
            };
          };
        };
      in
        import ./shell.nix {inherit pkgs checks;}
    );
    formatter.x86_64-linux = nixpkgs-unstable.legacyPackages.x86_64-linux.alejandra;

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      apollo = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs home-manager outputs;
          desktop = "gnome";
          hostname = "apollo";
          domain = "hosts.gordonschulz.de";
          hostid = "b39cf9a8";
          user = {
            name = "azmo";
            fullName = "Gordon Schulz";
            sshKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMUkEk7GV/qWMR9SJFYSJSxwnPxR8fG2Fn9VILHcyPYQ"];
          };
        };
        modules = [
          # > Our main nixos configuration file <
          ./hosts
        ];
      };
      artemis = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs home-manager outputs;
          desktop = "gnome";
          hostname = "artemis";
          domain = "hosts.gordonschulz.de";
          hostid = "b32cb9a7";
          user = {
            name = "azmo";
            fullName = "Gordon Schulz";
            sshKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMUkEk7GV/qWMR9SJFYSJSxwnPxR8fG2Fn9VILHcyPYQ"];
          };
        };
        modules = [
          # > Our main nixos configuration file <
          ./hosts
        ];
      };
      hephaestus = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs home-manager outputs;
          desktop = "gnome";
          hostname = "hephaestus";
          domain = "hosts.gordonschulz.de";
          hostid = "e120cab3";
          user = {
            name = "azmo";
            fullName = "Gordon Schulz";
            sshKeys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMUkEk7GV/qWMR9SJFYSJSxwnPxR8fG2Fn9VILHcyPYQ"];
          };
        };
        modules = [
          # > Our main nixos configuration file <
          ./hosts
        ];
      };
      # work-vm = nixpkgs-unstable.lib.nixosSystem {
      #   specialArgs = {
      #     inherit inputs home-manager outputs;
      #     desktop = "i3";
      #     hostname = "work-vm";
      #     domain = "f-i.de";
      #     hostid = "d6fb2da4";
      #     user = "j525980";
      #   };
      #   modules = [
      #     # > Our main nixos configuration file <
      #     ./hosts
      #   ];
      # };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "azmo@apollo" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          hostname = "apollo";
          user = {
            name = "azmo";
            uid = 1000;
            fullName = "Gordon Schulz";
            eMail = "gordon@gordonschulz.de";
            gpgKey = "0xDEE550054AA972F6";
          };
          desktop = {
            environment = "gnome";
            logitech = true;
          };
          pkgs-stable = nixpkgs.legacyPackages.x86_64-linux;
        };
        modules = [
          # > Our main home-manager configuration file <
          ./home/azmo/default.nix
          ./home/azmo/hosts/apollo.nix
        ];
      };
      "azmo@artemis" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          hostname = "artemis";
          user = {
            name = "azmo";
            uid = 1000;
            fullName = "Gordon Schulz";
            eMail = "gordon@gordonschulz.de";
            gpgKey = "0xDEE550054AA972F6";
          };
          desktop = {
            environment = "gnome";
            logitech = true;
          };
          pkgs-stable = nixpkgs.legacyPackages.x86_64-linux;
        };
        modules = [
          # > Our main home-manager configuration file <
          ./home/azmo/default.nix
          ./home/azmo/hosts/artemis.nix
        ];
      };
      "azmo@hephaestus" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          hostname = "hephaestus";
          user = {
            name = "azmo";
            uid = 1000;
            fullName = "Gordon Schulz";
            eMail = "gordon@gordonschulz.de";
            gpgKey = "0xDEE550054AA972F6";
          };
          desktop = {
            environment = "gnome";
            logitech = false;
          };
          pkgs-stable = nixpkgs.legacyPackages.x86_64-linux;
        };
        modules = [
          # > Our main home-manager configuration file <
          ./home/azmo/default.nix
          ./home/azmo/hosts/hephaestus.nix
        ];
      };
      # "j525980@work-vm" = home-manager.lib.homeManagerConfiguration {
      #   pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
      #   extraSpecialArgs = {
      #     inherit inputs outputs;
      #     desktop = {
      #       environment = "i3";
      #       logitech = false;
      #     };
      #     user = "j525980";
      #     pkgs-stable = nixpkgs.legacyPackages.x86_64-linux;
      #   };
      #   modules = [
      #     # > Our main home-manager configuration file <
      #     ./home/j525980/default.nix
      #     ./home/j525980/hosts/work-vm.nix
      #   ];
      # };
    };
  };
}
