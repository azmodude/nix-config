{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    #package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [
      # astronvim
      ripgrep
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
      golines
      # markdown
      marksman
      markdownlint-cli
      # javascript
      nodejs
      yarn
      # yaml
      yaml-language-server
    ];
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
    withPython3 = true;
    withNodeJs = true;
  };
  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.VISUAL = "nvim";

  xdg.configFile = {
    nvim = {
      enable = true;
      source = pkgs.fetchFromGitHub {
        owner = "azmodude";
        repo = "lazyvim";
        rev = "79bef2505b6e05e4f8835a3c4daa301d2ba6c192";
        sha256 = "0bxaxicf10hdnlmi26zmlkp1dhwaz4xl8xjg5bdv6snp2hd3hfm0";
      };
      # make files symbolic links to have .config/nvim writable by lazyvim
      recursive = true;
    };
  };

  programs.astronvim = {
    enable = false;
    userConfig = pkgs.fetchFromGitHub {
      owner = "azmodude";
      repo = "astronvim";
      rev = "caca9a4d5a9a1cb471a333553678bab49c9991a2";
      sha256 = "0si3qymp02pgq47y1bi72aaz2nfqsnd5aybkhpg8gljk5m9gnncn";
    };
  };
}
