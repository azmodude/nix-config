{ pkgs, ...}:
{
  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
        emacsPackage = pkgs.emacs-gtk;
  };
}