{pkgs, ...}: {
  home.packages = with pkgs; [mypy pylint black isort pyright jetbrains.pycharm-professional];
}
