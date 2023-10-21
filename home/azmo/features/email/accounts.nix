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
      msmtp.enable = true;
      passwordCommand = "${pkgs.coreutils}/bin/cat /run/user/${toString user.uid}/secrets/email/fastmail/gordon/password";
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
      msmtp.enable = true;
      passwordCommand = "${pkgs.coreutils}/bin/cat /run/user/${toString user.uid}/secrets/email/gmail/gordon/password";
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
