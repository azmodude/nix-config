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

      -- set xcursor size and theme from gnome
      -- source: https://github.com/wez/wezterm/issues/1742#issuecomment-1075333507
      -- could possibly be removed when wezterm gets full wayland support
      local xcursor_size = nil
      local xcursor_theme = nil

      local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-theme"})
      if success then
       xcursor_theme = stdout:gsub("'(.+)'\n", "%1")
      end

      local success, stdout, stderr = wezterm.run_child_process({"gsettings", "get", "org.gnome.desktop.interface", "cursor-size"})
      if success then
       xcursor_size = tonumber(stdout)
      end

      -- Pull in the wezterm API
      local wezterm = require("wezterm")

      -- This table will hold the configuration.
      local config = {}

      config = wezterm.config_builder()

      config = {
       color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
        font = wezterm.font_with_fallback(
        {
          "Iosevka SS14",
          "Symbols Nerd Font"
        }),
        font_size = 11,
        window_padding = {
          left = 5,
          right = 5,
          top = 2,
          bottom = 2,
        },
        hide_tab_bar_if_only_one_tab = true,
        use_fancy_tab_bar = true,
        xcursor_theme = xcursor_theme,
        xcursor_size = xcursor_size,
        window_frame = {
         font = wezterm.font { family = "Inter", weight = "Regular" },
         font_size = 10.0,
        },
        front_end = "WebGpu",
        window_background_opacity = 1.0,
        text_background_opacity = 1.0,
        term = "wezterm",
      }
      return config
    '';
  };
}
