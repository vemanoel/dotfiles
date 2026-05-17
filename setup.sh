#!/usr/bin/env sh

find $HOME/dotfiles -exec chmod +x {} +

sudo zypper install --no-confirm wget # download files
sudo zypper install --no-confirm curl # api testing
sudo zypper install --no-confirm firefox # browser
sudo zypper install --no-confirm iosevka-fonts # default font
sudo zypper install --no-confirm htop # process manager
sudo zypper install --no-confirm mpv # video player
sudo zypper install --no-confirm imv # image viewer
sudo zypper install --no-confirm bc # calculator
sudo zypper install --no-confirm make just # task runners
sudo zypper install --no-confirm go gopls # go toolchain
sudo zypper install --no-confirm gh # github cli
sudo zypper install --no-confirm glab # gitlab cli
sudo zypper install --no-confirm grim slurp # take screenshots
sudo zypper install --no-confirm fuzzel # applications runner
sudo zypper install --no-confirm mako libnotify-tools # manage notifications
sudo zypper install --no-confirm sway swaylock swayidle swaybg # window manager
sudo zypper install --no-confirm greetd tuigreet # session manager
sudo zypper install --no-confirm neovim # code editor
sudo zypper install --no-confirm wezterm # terminal
sudo zypper install --no-confirm dragon-drop tar zip unzip fdupes # files manager
sudo zypper install --no-confirm android-tools
sudo zypper install --no-confirm git
sudo zypper install --no-confirm NetworkManager
sudo zypper install --no-confirm telegram-desktop

sudo rm -rf /etc/{firefox,greetd}
ln -sfn $HOME/dotfiles/{firefox,greetd} /etc

rm -rf $HOME/.config/{wezterm,nvim,git,sway,fuzzel,mako}
ln -sfn $HOME/dotfiles/{wezterm,nvim,git,sway,fuzzel,mako} $HOME/.config

sudo systemctl set-default graphical.target
sudo systemctl enable greetd.service

# fyne
sudo zypper install --no-confirm docker
sudo usermod -G docker -a $USER
sudo zypper install --no-confirm gcc libXcursor-devel libXrandr-devel Mesa-libGL-devel libXi-devel libXinerama-devel libXxf86vm-devel libxkbcommon-devel
go install fyne.io/tools/cmd/fyne@latest
go install github.com/fyne-io/fyne-cross@latest

# apply changes
sudo reboot
