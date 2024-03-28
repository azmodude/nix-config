{pkgs, ...}: {
  # staticcheck is in gotools
  home.packages = with pkgs; [go jetbrains.goland gopls gofumpt gotools golines revive delve impl gomodifytags golangci-lint];
}
