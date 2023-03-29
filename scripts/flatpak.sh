#!/usr/bin/env bash

# enable flathub
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install common flatpaks
flatpak install --user -y flathub com.discordapp.Discord
flatpak install --user -y flathub com.usebottles.bottles
flatpak install --user -y flathub com.hamrick.VueScan
flatpak install --user -y md.obsidian.Obsidian

case "${XDG_CURRENT_DESKTOP}" in
  GNOME)
    #flatpak override --user --env=GTK_THEME=io.elementary.stylesheet.bubblegum:dark
    #flatpak remote-add --user --if-not-exists appcenter  https://flatpak.elementary.io/appcenter.flatpakrepo
    #flatpak remote-add --user --if-not-exists elementary https://flatpak.elementary.io/elementary.flatpakrepo
    ;;
  MATE)
    # flatpak override --user --env=GTK_THEME=Yaru-magenta-dark
    ;;
esac
