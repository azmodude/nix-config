{pkgs, ...}: {
  # add shells to /etc/shells
  environment.shells = with pkgs; [
    zsh
    bash
  ];
}
