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
      hadolint
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
  };
  home.sessionVariables.EDITOR = "nvim";
  home.sessionVariables.VISUAL = "nvim";
  programs.astronvim = {
    enable = true;
    userConfig = pkgs.fetchFromGitHub {
      owner = "azmodude";
      repo = "astronvim";
      rev = "174019b";
      sha256 = "sha256-PV/PeVmqHSBLvqBz0fPrVbyeiI4+Wk7F2gwaNo2VGp4=";
    };
  };
}
