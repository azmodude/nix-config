# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs {pkgs = final;};

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # override vivid until new version is cut.
    # catppuccin-theme is only in recent git commits
    vivid = prev.vivid.overrideAttrs (oldAttrs: rec {
      pname = "vivid";
      version = "0.8.0-4d7fb24";
      src = prev.fetchFromGitHub {
        owner = "sharkdp";
        repo = "${pname}";
        rev = "4d7fb24";
        sha256 = "sha256:rfEkeNrC5LHmUnTGv3tpIzpF+aSDCNmsnNsBQ/GC3Q4=";
      };
      cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
        name = "${pname}-vendor.tar.gz";
        inherit src;
        outputHash = "sha256-P+Mecvhm5vXvbZLT/mDEBsfB/hoUfaaTg6glD+5HznY=";
      });
    });
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
