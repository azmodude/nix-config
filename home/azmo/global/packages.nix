{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    exa
    google-chrome
    just
    lf
    nvtop
    rclone
    rsync
    ripgrep
    vivaldi
    vivaldi-ffmpeg-codecs
    unrar
    unzip
  ];
}
