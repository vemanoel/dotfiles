#!/usr/bin/env sh

sudo zypper refresh
sudo zypper up

sudo zypper install --no-confirm android-tools
sudo zypper install --no-confirm git
sudo zypper install --no-confirm NetworkManager
sudo zypper install --no-confirm telegram-desktop
sudo zypper install --no-confirm iosevka-fonts # fonts
sudo zypper install --no-confirm wget # download files
sudo zypper install --no-confirm curl # api testing
sudo zypper install --no-confirm firefox # browser
sudo zypper install --no-confirm htop # process manager
sudo zypper install --no-confirm mpv # video player
sudo zypper install --no-confirm imv # image viewer
sudo zypper install --no-confirm bc # calculator
sudo zypper install --no-confirm make just # task runners
sudo zypper install --no-confirm go gopls # go toolchain
sudo zypper install --no-confirm gh # github cli
sudo zypper install --no-confirm glab # gitlab cli
sudo zypper install --no-confirm grim slurp # take screenshots
sudo zypper install --no-confirm ddcutil # monitor manager
sudo zypper install --no-confirm wireplumber # volume manager
sudo zypper install --no-confirm fuzzel # applications runner
sudo zypper install --no-confirm mako libnotify-tools # notifications manager
sudo zypper install --no-confirm sway swaybar swaynag swaybg xwayland # window manager
sudo zypper install --no-confirm greetd tuigreet # session manager
sudo zypper install --no-confirm alacritty # terminal
sudo zypper install --no-confirm dragon-drop tar zip unzip fdupes # files manager
sudo zypper install --no-confirm helix # code editor

find $HOME/dotfiles -exec chmod +x {} +

sudo rm -rf /etc/{firefox,greetd}
sudo ln -sfn $HOME/dotfiles/{firefox,greetd} /etc

rm -rf $HOME/.config/{alacritty,helix,git,sway,fuzzel,mako}
ln -sfn $HOME/dotfiles/{alacritty,helix,git,sway,fuzzel,mako} $HOME/.config

ln -sfn $HOME/dotfiles/shell/.* $HOME

sudo systemctl set-default graphical.target
sudo systemctl enable greetd.service

sudo reboot
