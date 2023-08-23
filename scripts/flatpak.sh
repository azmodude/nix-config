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
	flatpak install --user -y com.valvesoftware.Steam.Utility.steamtinkerlaunch
	flatpak install --user -y net.davidotek.pupgui2
	flatpak install --user -y org.freedesktop.Platform.VulkanLayer.gamescope
	flatpak install --user -y org.freedesktop.Platform.VulkanLayer.MangoHud//22.08
	flatpak install --user -y org.freedesktop.Platform.VulkanLayer.OBSVkCapture//22.08
	flatpak install --user -y org.freedesktop.Platform.VulkanLayer.vkBasalt//22.08
	flatpak install --user -y com.heroicgameslauncher.hgl

	# allow bottles to create desktop links
	flatpak override com.usebottles.bottles --user --filesystem=xdg-data/applications

	# configure MangoHud
	for flatpak in com.valvesoftware.Steam com.heroicgameslauncher.hgl com.usebottles.bottles net.lutris.Lutris; do
		flatpak override --user --env=MANGOHUD=1 ${flatpak}
		flatpak override --user --filesystem=xdg-config/MangoHud:ro ${flatpak}
	done
	;;
esac
