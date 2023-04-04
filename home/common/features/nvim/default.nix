{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [nodejs gcc fzf python3 gdu bottom];
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
      rev = "1cb0cf8";
      sha256 = "sha256-aPJabKSDZ/Q1H1DxqPoEHJGkAtH1v9kaQ8SvHHLfGEI=";
    };
  };
}
