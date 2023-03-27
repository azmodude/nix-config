{ user, ...}:
{
  sops = {
    age.keyFile = "/home/${user}/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets.yaml;
    #    secrets.ssh-config-personal = {
    #      path = "%r/ssh/ssh-config-personal";
  };
}
