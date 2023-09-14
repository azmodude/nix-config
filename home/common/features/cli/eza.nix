{
  programs.eza = {
    enable = true;
    enableAliases = true;
    extraOptions = [
      "--group-directories-first"
      "--group"
    ];
    git = true;
    icons = true;
  };
  #  home.sessionVariables.EXA_ICON_SPACING = 2;
  home.shellAliases = {
    # list newest first
    lln = "eza -la --sort modified --reverse";
    # list oldest first
    llo = "eza -la --sort modified";
  };
}
