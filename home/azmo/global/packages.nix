{ pkgs, ...}:
{
  home.packages = with pkgs; [
    bat
    exa
    google-chrome
    just
    lf
    nvtop
    ripgrep
    vivaldi
    vivaldi-ffmpeg-codecs
    unrar
    unzip
  ];
}
