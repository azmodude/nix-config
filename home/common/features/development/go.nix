{pkgs, ...}: {
  # staticcheck is in gotools
  home.packages = with pkgs; [go gopls jetbrains.goland gofumpt gotools golines revive delve impl gomodifytags golangci-lint];
}
