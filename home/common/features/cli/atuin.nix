{config, ...}: {
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      enter_accept = true;
      sync_frequency = "5m";
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "host";
      inline_height = "40";
      update_check = "false";
      show_preview = "true";
      workspaces = "true";
    };
  };
  sops = {
    secrets.atuin-key = {
      sopsFile = ../../secrets.yaml;
      path = "${config.xdg.dataHome}/atuin/key";
    };
  };
}
