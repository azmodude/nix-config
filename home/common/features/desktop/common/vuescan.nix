{
  pkgs,
  user,
  ...
}: {
  sops.secrets.vuescan-license = {
    sopsFile = ../../../../${user.name}/secrets.yaml;
    path = ".vuescanrc";
  };

  home.packages = with pkgs; [vuescan];
}
