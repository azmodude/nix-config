{pkgs, ...}: {
  home.packages = with pkgs; [
    fd
    just
    lf
    mtr
    rclone
    rsync
    ripgrep
    unrar
    unzip
  ];
}
