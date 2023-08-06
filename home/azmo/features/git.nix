{
  programs.git = {
    userName = "Gordon Schulz";
    userEmail = "gordon@gordonschulz.de";
    ## ssh-key signing
    # gpg.format = "ssh";
    # gpg.ssh.program = "${pkgs._1password-gui}/share/1password/op-ssh-sign";
    # signing = {
    #   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICQh4341SBJaXdFAvDtAvS9zs4tiS5v8jod0OhgzBXpV";
    # };
    signing = {
      key = "0xDEE550054AA972F6";
    };
  };
}
