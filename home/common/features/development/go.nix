{pkgs, ...}: {
  # staticcheck is in gotools
  home.packages = with pkgs; [
    go
    gopls
    gofumpt
    gotools
    golines
    revive
    delve
    impl
    gomodifytags
    golangci-lint
    (jetbrains.plugins.addPlugins pkgs.jetbrains.goland [
      "github-copilot"
      "ideavim"
      "nixidea"
    ])
  ];
}
