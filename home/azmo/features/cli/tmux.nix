{pkgs, ...}: let
  catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "unstable-2022-12-14";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "e2561de";
      sha256 = "sha256:6UmFGkUDoIe8k+FrzdzsKrDHHMNfkjAk0yyc+HV199M=";
    };
    postInstall = ''
      sed -i -e 's|sed|${pkgs.gnused}/bin/sed|g;s|/bin/cat|${pkgs.coreutils}/bin/cat|g' $target/catppuccin.tmux
      # catppuccing tries to write to $target, patch that to point to /tmp instead
      sed -i -r "36s/\\$\{PLUGIN_DIR\}/\/tmp/g" $target/catppuccin.tmux
      sed -i -r "39s/\\$\{PLUGIN_DIR\}/\/tmp/g" $target/catppuccin.tmux
    '';
  };
in {
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
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'macchiato';
          set -g @catppuccin_window_tabs_enabled on
        '';
      }
    ];
  };
}
