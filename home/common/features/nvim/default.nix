{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    #package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [
      # astronvim
      ripgrep
      nodejs
      gcc
      fzf
      python3
      gdu
      bottom
      tree-sitter
      # python
      mypy
      pylint
      black
      isort
      pyright
      # docker
      nodePackages.dockerfile-language-server-nodejs
      # broken as of 08/20
      #hadolint
      # shell
      shellcheck
      shfmt
      nodePackages.bash-language-server
      # lua
      lua-language-server
      stylua
      selene
      # go
      gopls
      gofumpt
      gotools
      # markdown
      marksman
    ];
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };
  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.VISUAL = "nvim";

  programs.astronvim = {
    enable = true;
    userConfig = pkgs.fetchFromGitHub {
      owner = "azmodude";
      repo = "astronvim";
      rev = "caca9a4d5a9a1cb471a333553678bab49c9991a2";
      sha256 = "0si3qymp02pgq47y1bi72aaz2nfqsnd5aybkhpg8gljk5m9gnncn";
    };
  };
}
