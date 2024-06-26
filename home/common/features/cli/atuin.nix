{config, ...}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = true;
      enter_accept = true;
      sync_frequency = "5m";
      keymap_mode = "vim-insert";
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "host";
      inline_height = "40";
      update_check = "false";
      show_help = "true";
      show_preview = "true";
      workspaces = "true";
      sync = {
        records = "true";
      };
    };
  };
  sops = {
    secrets.atuin-key = {
      sopsFile = ../../secrets.yaml;
      path = "${config.xdg.dataHome}/atuin/key";
    };
  };
}
