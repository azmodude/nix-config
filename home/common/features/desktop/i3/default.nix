{pkgs, ...}: {
  xsession = {
    enable = true;
    windowManager.i3 = {
      enable = true;
      config = {
        terminal = "${pkgs.kitty}/bin/kitty";
        bars = [
          {
            statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs config-bottom.toml";
          }
        ];
      };
    };
  };
  programs.i3status-rust = {
    enable = true;
    bars = {
      bottom = {
        icons = "awesome6";
        blocks = [
          {
            block = "cpu";
          }
          {
            block = "load";
            format = " $icon $1m ";
          }
          {
            block = "memory";
            format = " $icon $mem_total_used_percents.eng(w:2) ";
            format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
          }
        ];
      };
    };
  };
}
