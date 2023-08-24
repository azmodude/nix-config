{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhs;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      golang.go
      mkhl.direnv
      github.copilot
      github.vscode-github-actions
    ];
  };
}
