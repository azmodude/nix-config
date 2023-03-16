{pkgs , ...}: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      golang.go
    ];
  };
  # enable Wayland
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
