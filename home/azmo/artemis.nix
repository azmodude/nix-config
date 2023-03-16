{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./global
    ./features/cli
    ./features/desktop/common
    ./features/desktop/gnome
    ./features/gaming
    ./features/nvim
    ./features/emacs
    ./features/desktop/common/vscode.nix
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
  sops = {
    age.keyFile = "/home/azmo/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    #    secrets.ssh-config-personal = {
    #      path = "%r/ssh/ssh-config-personal";
    secrets.ssh-config-personal = {
      path = ".ssh/config.d/ssh-config-personal";
    };
  };
}
