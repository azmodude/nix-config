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

       -- Pull in the wezterm API
      local wezterm = require("wezterm")

      -- This table will hold the configuration.
      local config = {}

      -- In newer versions of wezterm, use the config_builder which will
      -- help provide clearer error messages
      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

      config = {
        initial_rows = 50,
        initial_cols = 140,
        color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
        window_padding = {
          left = 5,
          right = 5,
          top = 2,
          bottom = 2,
        },
        use_fancy_tab_bar = true,
        hide_tab_bar_if_only_one_tab = true,
        font = wezterm.font("Iosevka SS14", { weight = "Light" }),
        font_size = 11,
        freetype_render_target = "HorizontalLcd",
        cursor_blink_rate = 0,
        window_frame = {
          font = wezterm.font({ family = "Inter", weight = "Regular" }),
          font_size = 10.0,
        },
        window_background_opacity = 1.0,
        text_background_opacity = 1.0,
        term = "wezterm",
        front_end = "WebGpu",

        keys = {
          {
            key = "w",
            mods = "CMD",
            action = wezterm.action.CloseCurrentTab({ confirm = true }),
          },
        },
      }

      return config
    '';
  };
}
