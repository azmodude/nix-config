user := env_var('USER')
host := `hostname`

default:
    just --list
# install home-manager for user=<user@host>
hm-install:
    nix build --no-link .#homeConfigurations.{{user}}@{{host}}.activationPackage
    "$(nix path-info .#homeConfigurations.{{user}}@{{host}}.activationPackage)"/activate
# switch home-manager for user=<user@host>
hm-switch:
    home-manager switch --flake .?submodules=1#{{user}}@{{host}}
# update flakes
update-flake-only:
    nix flake update
# update for host=<host>
switch:
    sudo nixos-rebuild switch --flake .?submodules=1#{{host}}
boot:
    sudo nixos-rebuild boot --flake .?submodules=1#{{host}}
# update flakes and rebuild-switch for host=<host>
update: update-flake-only && switch hm-switch


