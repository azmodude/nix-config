{
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
      font = wezterm.font("Iosevka Nerd Font"),
      font_size = 11.0,
      hide_tab_bar_if_only_one_tab = true,
    }
    '';
  };
}
