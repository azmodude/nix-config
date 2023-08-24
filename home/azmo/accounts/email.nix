{
  config,
  pkgs,
  user,
  ...
}: {
  accounts.email.accounts = {
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
      passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets."email/fastmail/gordon/password".path}";
      realName = "${user.fullName}";
      signature = {
        showSignature = true;
        text =
          ''
            Best,
              /''
          + "${user.fullName}";
      };
      thunderbird = {
        enable = true;
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
      passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets."email/gmail/gordon/password".path}";
      realName = "${user.fullName}";
      signature = {
        showSignature = true;
        text = ''
          Best,
            /${user.fullName}
        '';
      };
      thunderbird = {
        enable = true;
      };
    };
    yahoo = {
      address = "schulz.gordon@yahoo.de";
      userName = "schulz.gordon@yahoo.de";
      passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets."email/yahoo/gordon/password".path}";
      realName = "${user.fullName}";
      flavor = "plain";
      imap = {
        host = "imap.mail.yahoo.com";
        port = 993;
      };
      smtp = {
        host = "smtp.mail.yahoo.com";
        port = 587;
      };
      thunderbird = {
        enable = true;
      };
    };
    yahoo-throwaway = {
      address = "meierfred33@yahoo.de";
      userName = "meierfred33@yahoo.de";
      passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets."email/yahoo/throwaway/password".path}";
      realName = "Fred Meier";
      flavor = "plain";
      imap = {
        host = "imap.mail.yahoo.com";
        port = 993;
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
}
