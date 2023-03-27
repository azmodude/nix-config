{pkgs, ...}: {
  home.packages = with pkgs; [
    comma
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
