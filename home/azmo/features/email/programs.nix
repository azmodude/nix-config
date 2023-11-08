{pkgs, ...}: let
  neomutt-catpuccin-macchiato =
    builtins.readFile
    (pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "neomutt";
        rev = "f6ce83da47cc36d5639b0d54e7f5f63cdaf69f11";
        sha256 = "sha256-ye16nP2DL4VytDKB+JdMkBXU+Y9Z4dHmY+DsPcR2EG0=";
      }
      + "/neomuttrc");
in {
  programs = {
    msmtp = {
      enable = true;
    };
    mbsync = {
      enable = true;
    };
    neomutt = {
      enable = true;
      sidebar = {
        enable = true;
        shortPath = true;
        width = 30;
      };
      vimKeys = true;
      extraConfig = ''
        set date_format="%Y/%m/%d %T"
        set index_format="%2C | %Z [%d] %-0.15g %-30.30F (%-4.4c) %s"
          # recently active thread/subthread first
          set sort_aux=reverse-last-date
          ignore *
          unignore from date subject to cc
          unignore posted-to:
          unignore organization organisation x-mailer: x-newsreader: x-mailing-list:
          unignore Folder tags

          ${neomutt-catpuccin-macchiato}
      '';
    };
    notmuch = {
      enable = true;
    };
  };
  services.mbsync = {
    enable = false;
    frequency = "*:0/5";
    postExec = "${pkgs.notmuch}/bin/notmuch new";
    verbose = true;
  };
}
