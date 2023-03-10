{
  description = "azmo's flake, based on Misterio77's (https://github.com/Misterio77) awesome nix-starter-configs and nix-config repositories.";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # persistance (or not)
    impermanence.url = "github:nix-community/impermanence";
    # nightly neovim awesomeness
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    hardware.url = "github:nixos/nixos-hardware";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs [
      "aarch64-linux"
      "i686-linux"
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
        pkgs = nixpkgs.legacyPackages.${system};
      in
        import ./shell.nix {inherit pkgs;}
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
      # FIXME replace with your hostname
      hephaestus = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs home-manager outputs;
          desktop = "gnome";
        };
        modules = [
          # > Our main nixos configuration file <
          ./hosts/hephaestus
        ];
      };
      artemis = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = {
          inherit inputs home-manager outputs;
          desktop = "gnome";
        };
        modules = [
          # > Our main nixos configuration file <
          ./hosts/artemis
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "azmo@hephaestus" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          desktop = "gnome";
          pkgs-stable = nixpkgs.legacyPackages.x86_64-linux;
        };
        modules = [
          # > Our main home-manager configuration file <
          ./home/azmo/hephaestus.nix
        ];
      };
      "azmo@artemis" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-unstable.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
        extraSpecialArgs = {
          inherit inputs outputs;
          desktop = "gnome";
          pkgs-stable = nixpkgs.legacyPackages.x86_64-linux;
        };
        modules = [
          # > Our main home-manager configuration file <
          ./home/azmo/artemis.nix
        ];
      };
    };
  };
}
