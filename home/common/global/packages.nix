{pkgs, ...}: {
  home.packages = with pkgs; [
    fd
    just
    lf
    rclone
    rsync
    ripgrep
    unrar
    unzip
  ];
}
