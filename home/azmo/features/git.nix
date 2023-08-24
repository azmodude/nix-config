{user, ...}: {
  programs.git = {
    userName = user.fullName;
    userEmail = user.eMail;
    ## ssh-key signing
    # gpg.format = "ssh";
    # gpg.ssh.program = "${pkgs._1password-gui}/share/1password/op-ssh-sign";
    # signing = {
    #   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICQh4341SBJaXdFAvDtAvS9zs4tiS5v8jod0OhgzBXpV";
    # };
    signing = {
      key = user.gpgKey;
    };
  };
}
