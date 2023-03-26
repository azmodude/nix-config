{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      golang.go
      mkhl.direnv
    ];
  };
  # enable Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
