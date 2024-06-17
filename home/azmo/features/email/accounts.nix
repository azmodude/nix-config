{
  config,
  pkgs,
  user,
  ...
}: let
  maildirBasePath = "mail";
  signatureText = "Best,\n/${user.fullName}";
in {
  accounts.email = {
    maildirBasePath = "${maildirBasePath}";
    accounts = {
      fastmail-gordon = {
        address = "gordon@gordonschulz.de";
        userName = "gordon@gordonschulz.de";
        primary = true;
        flavor = "fastmail.com";
        gpg = {
          key = user.gpgKey;
          encryptByDefault = false;
          signByDefault = false;
        };
        mbsync = {
          enable = true;
          create = "maildir";
          patterns = ["*" "!Snoozed"];
        };
        msmtp.enable = true;
        neomutt = {
          enable = true;
        };
        notmuch = {
          enable = true;
          neomutt.virtualMailboxes = [
            {
              name = "fastmail-inbox";
              query = "tag:inbox";
            }
          ];
        };
        passwordCommand = "${pkgs.coreutils}/bin/cat /run/user/${toString user.uid}/secrets/email/fastmail/gordon/password";
        realName = "${user.fullName}";
        signature = {
          showSignature = "append";
          text = "${signatureText}";
        };
        thunderbird = {
          enable = true;
          perIdentitySettings = id: {
            "mail.identity.id_${id}.htmlSigText" = "${signatureText}";
          };
        };
      };
      gmail-gordon = {
        address = "gordon.schulz@gmail.com";
        userName = "gordon.schulz@gmail.com";
        flavor = "gmail.com";
        gpg = {
          key = user.gpgKey;
          encryptByDefault = false;
          signByDefault = false;
        };
        msmtp.enable = true;
        passwordCommand = "${pkgs.coreutils}/bin/cat /run/user/${toString user.uid}/secrets/email/gmail/gordon/password";
        realName = "${user.fullName}";
        signature = {
          showSignature = "append";
          text = "${signatureText}";
        };
        thunderbird = {
          enable = true;
          perIdentitySettings = id: {
            "mail.identity.id_${id}.htmlSigText" = "${signatureText}";
          };
        };
      };
      yahoo-throwaway = {
        address = "meierfred33@yahoo.de";
        userName = "meierfred33@yahoo.de";
        passwordCommand = "${pkgs.coreutils}/bin/cat /run/user/${toString user.uid}/secrets/email/yahoo/throwaway/password";
        realName = "Fred Meier";
        flavor = "plain";
        imap = {
          host = "imap.mail.yahoo.com";
          port = 993;
        };
        mbsync = {
          enable = true;
          create = "maildir";
        };
        neomutt = {
          enable = true;
        };
        notmuch = {
          enable = true;
          neomutt.virtualMailboxes = [
            {
              name = "yahoo-throwaway-inbox";
              query = "tag:inbox";
            }
          ];
        };
        smtp = {
          host = "smtp.mail.yahoo.com";
          port = 587;
        };
        thunderbird = {
          enable = true;
        };
      };
    };
  };

  sops = {
    secrets."email/fastmail/gordon/password" = {
      sopsFile = ./secrets.yaml;
    };
    secrets."email/gmail/gordon/password" = {
      sopsFile = ./secrets.yaml;
    };
    secrets."email/yahoo/throwaway/password" = {
      sopsFile = ./secrets.yaml;
    };
  };
  home = {
    persistence = {
      "/persist/home/${user.name}" = {
        directories = [
          "${maildirBasePath}"
        ];
      };
    };
  };
}
