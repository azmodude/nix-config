{pkgs, ...}: {
  home.packages = with pkgs; [
    devenv
    fd
    just
    lf
    mtr
    openvpn
    rclone
    rsync
    ripgrep
    unrar
    unzip
  ];
}
