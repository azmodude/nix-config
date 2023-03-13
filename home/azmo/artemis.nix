{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./global
    ./features/cli/atuin.nix
    ./features/cli/btop.nix
    ./features/cli/direnv.nix
    ./features/cli/fzf.nix
    ./features/cli/gpg.nix
    ./features/cli/git.nix
    ./features/cli/ssh.nix
    ./features/cli/starship.nix
    ./features/cli/tmux.nix
    ./features/cli/zellij.nix
    ./features/cli/zsh.nix
    ./features/desktop/common/alacritty.nix
    ./features/desktop/common/firefox.nix
    ./features/desktop/common/fonts.nix
    ./features/desktop/common/kitty.nix
    ./features/desktop/gnome
    ./features/desktop/common/wezterm.nix
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
