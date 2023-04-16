{config, ...}: {
  sops.secrets.rclone-config = {
    sopsFile = ../secrets.yaml;
    path = "${config.xdg.configHome}/rclone/rclone.conf";
  };
}
