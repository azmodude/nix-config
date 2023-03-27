{config, ...}: {
  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      filter_mode = "global";
      filter_mode_shell_up_key_binding = "host";
      update_check = "false";
    };
  };
  sops = {
    secrets.atuin-key = {
      sopsFile = ../../secrets.yaml;
      path = "${config.xdg.dataHome}/atuin/key";
    };
  };
}
