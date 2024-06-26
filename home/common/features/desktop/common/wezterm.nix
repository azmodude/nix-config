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

            function xcursor_theme_for_appearance()
              -- might be able to remove once wezterm gets proper wayland support
              local wezterm = require("wezterm")
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

              return xcursor_theme, xcursor_size
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

            local xcursor_theme, xcursor_size = xcursor_theme_for_appearance()

            config = {
              integrated_title_buttons = { 'Close' },
              window_decorations = "INTEGRATED_BUTTONS|RESIZE",
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
              hide_tab_bar_if_only_one_tab = false,
              font = wezterm.font("Iosevka SS14", { weight = "Light" }),
      --        font = wezterm.font("FiraCode", { weight = "Light" }),
              font_size = 11,
              font_rules = {
                {
                  intensity = 'Bold',
                  italic = true,
                  font = wezterm.font {
                    family = 'VictorMono',
                    weight = 'Bold',
                    style = 'Italic',
                  },
                },
                {
                  italic = true,
                  intensity = 'Half',
                  font = wezterm.font {
                    family = 'VictorMono',
                    weight = 'DemiBold',
                    style = 'Italic',
                  },
                },
                {
                  italic = true,
                  intensity = 'Normal',
                  font = wezterm.font {
                    family = 'VictorMono',
                    style = 'Italic',
                  },
                },
              },
              freetype_load_target = "Normal",
              freetype_render_target = "Normal",
              freetype_interpreter_version = 40,
              cursor_blink_rate = 0,
              window_frame = {
                font = wezterm.font({ family = "Inter", weight = "Regular" }),
                font_size = 10.0,
              },
              window_background_opacity = 1.0,
              text_background_opacity = 1.0,
              term = "wezterm",
              front_end = "WebGpu",
              xcursor_theme = xcursor_theme,
              xcursor_size = xcursor_size,

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
