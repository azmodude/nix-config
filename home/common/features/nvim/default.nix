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
      # docker
      nodePackages.dockerfile-language-server-nodejs
      hadolint
      # shell
      shellcheck
      shfmt
      nodePackages.bash-language-server
      # lua
      lua-language-server
      stylua
      selene
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
        rev = "b26ad055e4cb2ea67818bdd0cebcd737d7592c28";
        sha256 = "0sz2qzxhgv5ld3vwbbiklpj6jn6h3z11zfy0hdvmiz1yz8y522kz";
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
