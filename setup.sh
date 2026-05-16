#!/usr/bin/env sh

sudo zypper install --no-confirm sway swaylock swayidle swaybg mako grim slurp fuzzel libnotify-tools
sudo zypper install --no-confirm firefox htop mpv imv bc dragon-drop telegram-desktop wezterm NetworkManager tar zip unzip fdupes
sudo zypper install --no-confirm git neovim make go gopls gh glab curl
sudo zypper install --no-confirm iosevka-fonts

sudo zypper install --no-confirm docker
sudo usermod -G docker -a $USER
sudo zypper install --no-confirm gcc android-tools libXcursor-devel libXrandr-devel Mesa-libGL-devel libXi-devel libXinerama-devel libXxf86vm-devel libxkbcommon-devel
go install fyne.io/tools/cmd/fyne@latest
go install github.com/fyne-io/fyne-cross@latest

rm -rf $HOME/.config/{sway,fuzzel,mako,git}
ln -sfn $HOME/dotfiles/{sway,fuzzel,mako,git} $HOME/.config

sudo zypper install --no-confirm greetd tuigreet
sudo rm -rf /etc/greetd
sudo ln -sfn $HOME/dotfiles/greetd /etc/greetd
sudo systemctl set-default graphical.target
sudo systemctl enable greetd.service

sudo reboot
