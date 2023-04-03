# Shell for bootstrapping flake-enabled nix and other tooling
{
  checks ? {
    pre-commit-check = {
    };
  },
  pkgs ?
  # If pkgs is not defined, instanciate nixpkgs from locked commit
  let
    lock = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
    nixpkgs = fetchTarball {
      url = "https://github.com/nixos/nixpkgs/archive/${lock.rev}.tar.gz";
      sha256 = lock.narHash;
    };
  in
    import nixpkgs {overlays = [];},
  ...
}: {
  default = pkgs.mkShell {
    NIX_CONFIG = "extra-experimental-features = nix-command flakes repl-flake";
    inherit (checks.pre-commit-check) shellHook;
    nativeBuildInputs = with pkgs; [
      nix
      home-manager
      git
      zellij

      sops
      gnupg
      age
      ssh-to-age

      just
    ];
  };
}
