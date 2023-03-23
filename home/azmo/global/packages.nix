{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    comma
    exa
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
