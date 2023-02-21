{
  inputs,
  pkgs,
  pkgs-stable,
  ...
}: {
  imports = [
    ./global
    ./features/cli/atuin.nix
    ./features/cli/direnv.nix
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
    ./features/desktop/gnome
    ./features/nvim
    ./features/desktop/common/vscode.nix
  ];
  home.packages = with pkgs; [
    bat
    exa
    google-chrome
    intel-gpu-tools
    just
    pkgs.inter
    ripgrep
    vivaldi
    vivaldi-ffmpeg-codecs
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
  sops = {
    age.keyFile = "/home/azmo/.config/sops/age/keys.txt";
    defaultSopsFile = ./secrets.yaml;
    secrets.test = {
      path = "%r/test.txt";
    };
  };
}
