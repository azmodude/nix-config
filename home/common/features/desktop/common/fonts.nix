{
  pkgs,
  config,
  user,
  ...
}: {
  fonts.fontconfig = {
    enable = true;
  };

  home.packages = with pkgs; [
    # Add extra font packages here
  ];

  # create symbolic link for flatpaks
  systemd.user.tmpfiles.rules = [
    "L ${config.xdg.dataHome}/fonts - - - - /run/current-system/sw/share/X11/fonts"
  ];
}
