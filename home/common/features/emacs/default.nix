{
  pkgs,
  config,
  ...
}: let
  spacemacsdir = "${config.xdg.configHome}/spacemacs";
in {
  programs.emacs.enable = true;
  home.file."${config.xdg.configHome}/emacs" = {
    source = pkgs.fetchFromGitHub {
      owner = "syl20bnr";
      repo = "spacemacs";
      rev = "5600e4f";
      sha256 = "v9ezE0eSwNQDoBLFggnTMTx4qApKHXugh4v0MO/H3zE=";
    };
    recursive = true;
  };
  home.sessionVariables."SPACEMACSDIR" = spacemacsdir;
  home.file."${spacemacsdir}/init.el".source = ./spacemacs-init.el;
}
