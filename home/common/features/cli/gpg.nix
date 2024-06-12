{
  pkgs,
  config,
  lib,
  desktop,
  user,
  ...
}: let
  fetchKey = {
    url,
    sha256 ? lib.fakeSha256,
  }:
    builtins.fetchurl {inherit sha256 url;};

  pinentry =
    if desktop.environment == "plasma"
    then {
      package = pkgs.pinentry-qt;
      name = "qt";
    }
    else if desktop.environment == "gnome"
    then {
      package = pkgs.pinentry-gnome3;
      name = "pinentry-gnome3";
    }
    else {
      package = pkgs.pinentry-curses;
      name = "curses";
    };
in {
  home.packages = [pinentry.package];

  services.gpg-agent = {
    enable = true;
    enableSshSupport = false;
    pinentryPackage = pinentry.package;
    enableExtraSocket = true;
  };

  programs = let
    fixGpg = ''
      gpgconf --launch gpg-agent
    '';
  in {
    # Start gpg-agent if it's not running or tunneled in
    # SSH does not start it automatically, so this is needed to avoid having to use a gpg command at startup
    # https://www.gnupg.org/faq/whats-new-in-2.1.html#autostart
    bash.profileExtra = fixGpg;
    #      fish.loginShellInit = fixGpg;
    zsh.loginExtra = fixGpg;

    gpg = {
      enable = true;
      settings = {
        trust-model = "tofu+pgp";
      };
      publicKeys = [
        {
          source = fetchKey {
            url = "https://github.com/azmodude.gpg";
            sha256 = "sha256:1s9y4k90hjl7k75is6lyp491hg1my3vm1kxxahyslj5wy7w09pi8";
          };
          trust = 5;
        }
      ];
    };
  };
  home.persistence = {
    "/persist/home/${user.name}" = {
      directories = [".gnupg"];
    };
  };

  # ensure .gnupg is secure
  systemd.user.tmpfiles.rules = [
    "z /home/${user.name}/.gnupg 0700 ${user.name} ${user.name} - -"
  ];

  #
  #  # Link /run/user/$UID/gnupg to ~/.gnupg-sockets
  #  # So that SSH config does not have to know the UID
  #  systemd.user.services.link-gnupg-sockets = {
  #    Unit = {
  #      Description = "link gnupg sockets from /run to /home";
  #    };
  #    Service = {
  #      Type = "oneshot";
  #      ExecStart = "${pkgs.coreutils}/bin/ln -Tfs /run/user/%U/gnupg %h/.gnupg-sockets";
  #      ExecStop = "${pkgs.coreutils}/bin/rm $HOME/.gnupg-sockets";
  #      RemainAfterExit = true;
  #    };
  #    Install.WantedBy = [ "default.target" ];
  #  };
}
# vim: filetype=nix

