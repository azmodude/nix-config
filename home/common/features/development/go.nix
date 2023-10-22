{pkgs, ...}: {
  home.packages = with pkgs; [go gopls jetbrains.goland gofumpt gotools delve];
}
