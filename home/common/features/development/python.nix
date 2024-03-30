{pkgs, ...}: {
  home.packages = with pkgs; [
    mypy
    pylint
    black
    isort
    pyright
    (jetbrains.plugins.addPlugins pkgs.jetbrains.pycharm-professional [
      "github-copilot"
      "ideavim"
      "nixidea"
    ])
  ];
}
