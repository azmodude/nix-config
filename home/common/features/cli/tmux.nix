{pkgs, ...}:
# let
#   catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
#     pluginName = "catppuccin";
#     version = "unstable-4348b09";
#     src = pkgs.fetchFromGitHub {
#       owner = "catppuccin";
#       repo = "tmux";
#       rev = "4e48b09";
#       sha256 = "sha256-bXEsxt4ozl3cAzV3ZyvbPsnmy0RAdpLxHwN82gvjLdU=";
#     };
#     postInstall = ''
#       sed -i -e 's|sed|${pkgs.gnused}/bin/sed|g;s|/bin/cat|${pkgs.coreutils}/bin/cat|g' $target/catppuccin.tmux
#       # catppuccing tries to write to $target, patch that to point to /tmp instead
#       sed -i -r "36s/\\$\{PLUGIN_DIR\}/\/tmp/g" $target/catppuccin.tmux
#       sed -i -r "39s/\\$\{PLUGIN_DIR\}/\/tmp/g" $target/catppuccin.tmux
#     '';
#   };
let
  catppuccin = pkgs.tmuxPlugins.catppuccin.overrideAttrs (oldAttrs: rec {
    version = "unstable-4348b09";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "4e48b09";
      sha256 = "sha256-bXEsxt4ozl3cAzV3ZyvbPsnmy0RAdpLxHwN82gvjLdU=";
    };
  });
in {
  programs.tmux = {
    enable = true;
    customPaneNavigationAndResize = true;
    keyMode = "vi";
    mouse = true;
    newSession = true;
    tmuxp.enable = true;
    sensibleOnTop = true;
    terminal = "tmux-256color";
    extraConfig = ''
      set-option -ga terminal-overrides ",*256col*:Tc:RGB"
    '';
    plugins = with pkgs; [
      {
        plugin = tmuxPlugins.prefix-highlight;
      }
      {
        plugin = tmuxPlugins.pain-control;
      }
      {
        plugin = tmuxPlugins.yank;
      }
      {
        plugin = tmuxPlugins.tmux-fzf;
      }
      {
        plugin = tmuxPlugins.vim-tmux-navigator;
      }
      {
        plugin = tmuxPlugins.vim-tmux-focus-events;
      }
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour "macchiato"
          set -g @catppuccin_window_tabs_enabled "on"
          set -g @catppuccin_date_time "%Y-%m-%d %H:%M"
          set -g @catppuccin_user "on"
          set -g @catppuccin_host "on"
        '';
      }
    ];
  };
}
