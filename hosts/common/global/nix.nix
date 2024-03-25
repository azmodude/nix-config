{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  nix = {
    settings = {
      trusted-users = ["root" "@wheel"];
      auto-optimise-store = lib.mkDefault true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      warn-dirty = false;
      system-features = ["kvm" "big-parallel"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      # Delete older generations too
      options = "--delete-older-than 7d";
    };

    # this should no longer be neccessary and is handled by
    # https://github.com/NixOS/nixpkgs/commit/e456032addae76701eb17e6c03fc515fd78ad74f
    # Add each flake input as a registry
    # To make nix3 commands consistent with the flake
    # registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # Add nixpkgs input to NIX_PATH
    # This lets nix2 commands still use <nixpkgs>
    # nixPath = [ "nixpkgs=${inputs.nixpkgs.outPath}" ];
  };
  environment.systemPackages = with pkgs; [nix-prefetch-scripts];
}
