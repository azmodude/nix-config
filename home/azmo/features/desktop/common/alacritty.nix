{pkgs, ...}: {
  home.file.".config/alacritty/themes/catppuccin" = {
    source = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "alacritty";
      rev = "3c808cb";
      sha256 = "w9XVtEe7TqzxxGUCDUR9BFkzLZjG8XrplXJ3lX6f+x0=";
    };
  };
  programs.alacritty = {
    enable = true;
    settings = {
      import = ["/home/azmo/.config/alacritty/themes/catppuccin/catppuccin-macchiato.yml"];
      window.padding = {
        x = 5;
        y = 0;
      };
      cursor = {
        style.blinking = "Always";
        blink_timeout = 30;
        unfocused_hollow = true;
      };
      font = {
        normal = {
          family = "Iosevka Nerd Font";
          style = "Complete";
        };
        bold = {
          family = "Iosevka Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "Iosevka Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "Iosevka Nerd Font";
          style = "Bold Italic";
        };
        size = 11;
      };
      key_bindings = [
        {
          # use different ToggleViMode keybinding since default clashes with 1Password
          key = "Space";
          mods = "Control|Alt";
          mode = "~Search";
          action = "ToggleViMode";
        }
        {
          key = "Space";
          mods = "Control|Shift";
          action = "ReceiveChar";
        }
        {
          # modify vim mode search keybindings
          key = "Slash";
          mods = "Shift";
          mode = "Vi|~Search";
          action = "SearchForward";
        }
        {
          key = "Backslash";
          mode = "Vi|~Search";
          action = "SearchBackward";
        }
        {
          # send CR on numpadenter to fix tmux
          key = "NumpadEnter";
          chars = "\r";
        }
      ];
      live_config_reload = true;
    };
  };
}
