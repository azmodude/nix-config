{pkgs, ...}: {
  home.packages = with pkgs; [
    comma
    flameshot
    google-chrome
    just
    lf
    nvtop
    rclone
    rsync
    ripgrep
    thunderbird
    vivaldi
    vivaldi-ffmpeg-codecs
    unrar
    unzip
  ];
}
