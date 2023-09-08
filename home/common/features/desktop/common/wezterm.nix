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

      return {
       -- ...your existing config
       color_scheme = scheme_for_appearance(wezterm.gui.get_appearance()),
        font = wezterm.font_with_fallback(
        {
          "Iosevka SS14",
          "Symbols Nerd Font"
        }),
        font_size = 11,
        hide_tab_bar_if_only_one_tab = true,
        xcursor_theme = xcursor_theme,
        xcursor_size = xcursor_size,
        window_frame = {
         font = wezterm.font { family = "Inter", weight = "Bold" },
         font_size = 10.0,
        },
        window_padding = {
         left = 5,
         right = 5,
        },
        front_end = "WebGpu"
      }
    '';
  };
}
