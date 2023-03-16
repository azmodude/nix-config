{
  sops = {
    age.keyFile = "/home/azmo/.config/sops/age/keys.txt";
    defaultSopsFile = ../secrets.yaml;
    #    secrets.ssh-config-personal = {
    #      path = "%r/ssh/ssh-config-personal";
    secrets.ssh-config-personal = {
      path = ".ssh/config.d/ssh-config-personal";
    };
  };
}
