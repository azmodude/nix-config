{config, ...}: {
  accounts.email.accounts = {
    fastmail-gordon = {
      address = "gordon@gordonschulz.de";
      primary = true;
      flavor = "fastmail.com";
      gpg = {
        key = "0xDEE550054AA972F6";
        encryptByDefault = false;
        signByDefault = false;
      };
      passwordCommand = "cat ${config.sops.secrets."email/fastmail_gordon_password".path}";
      realName = "Gordon Schulz";
      signature = {
        showSignature = true;
        text = ''
          Best,
            /Gordon Schulz
        '';
      };
      thunderbird = {
        enable = true;
      };
    };
  };

  sops = {
    secrets."email/fastmail_gordon_password" = {
      sopsFile = ./secrets.yaml;
    };
  };
}
