{pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      function scheme_for_appearance(appearance)
       if appearance:find "Dark" then
        return "Catppuccin Macchiato"
       else
        return "Catppuccin Latte"
       end
      end

      return {
       -- ...your existing config
       color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
        font = wezterm.font_with_fallback(
        {
          "Iosevka",
          "Symbols Nerd Font"
        }),
        font_size = 10.5,
        hide_tab_bar_if_only_one_tab = true,
        xcursor_theme = "Adwaita",
        window_frame = {
         font = wezterm.font { family = "Inter", weight = "Bold" },
         font_size = 10.0,
        },
        window_padding = {
         left = 5,
         right = 5,
        },
      }
    '';
  };
}
