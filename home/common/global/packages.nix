{pkgs, ...}: {
  home.packages = with pkgs; [
    comma
    fd
    flameshot
    google-chrome
    just
    lf
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
