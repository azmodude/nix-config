{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    #package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [ripgrep nodejs gcc fzf python3 gdu bottom tree-sitter];
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
      rev = "2346e5b";
      sha256 = "sha256-wQH0XnsM6rbPZjId8f8hY3cg6lyAdJJQfAQ9eRlhENk=";
    };
  };
}
