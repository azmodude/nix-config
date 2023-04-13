#!/usr/bin/env bash

# enable flathub
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# install common flatpaks
flatpak install --user -y flathub com.discordapp.Discord
flatpak install --user -y flathub com.hamrick.VueScan
flatpak install --user -y md.obsidian.Obsidian
flatpak install --user -y org.flameshot.Flameshot

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

case "$(hostname)" in
artemis)
	flatpak install --user -y net.lutris.Lutris
	flatpak install --user -y com.valvesoftware.Steam
	flatpak install --user -y com.valvesoftware.Steam.Utility.gamescope
	flatpak install --user -y com.usebottles.bottles
	;;
esac
