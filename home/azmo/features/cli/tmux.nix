{pkgs, ...}: {
  programs.tmux = {
    enable = true;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    tmuxp.enable = true;
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.prefix-highlight;
      }
      {
        plugin = tmuxPlugins.pain-control;
      }
    ];
  };
}
