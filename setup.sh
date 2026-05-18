#!/usr/bin/env sh

find $HOME/dotfiles -exec chmod +x {} +

sudo zypper install --no-confirm iosevka-fonts # default font
sudo zypper install --no-recommends --no-confirm wget # download files
sudo zypper install --no-recommends --no-confirm curl # api testing
sudo zypper install --no-recommends --no-confirm firefox # browser
sudo zypper install --no-recommends --no-confirm htop # process manager
sudo zypper install --no-recommends --no-confirm mpv # video player
sudo zypper install --no-recommends --no-confirm imv # image viewer
sudo zypper install --no-recommends --no-confirm bc # calculator
sudo zypper install --no-recommends --no-confirm make just # task runners
sudo zypper install --no-recommends --no-confirm go gopls # go toolchain
sudo zypper install --no-recommends --no-confirm gh # github cli
sudo zypper install --no-recommends --no-confirm glab # gitlab cli
sudo zypper install --no-recommends --no-confirm grim slurp # take screenshots
sudo zypper install --no-recommends --no-confirm ddcutil # monitor manager
sudo zypper install --no-recommends --no-confirm wireplumber # volume manager
sudo zypper install --no-recommends --no-confirm fuzzel # applications runner
sudo zypper install --no-recommends --no-confirm mako libnotify-tools # notifications manager
sudo zypper install --no-recommends --no-confirm sway swaybar swaynag swaybg pango cairo # window manager
sudo zypper install --no-recommends --no-confirm greetd tuigreet # session manager
sudo zypper install --no-recommends --no-confirm neovim # code editor
sudo zypper install --no-recommends --no-confirm alacritty # terminal
sudo zypper install --no-recommends --no-confirm dragon-drop tar zip unzip fdupes # files manager
sudo zypper install --no-recommends --no-confirm android-tools
sudo zypper install --no-recommends --no-confirm anki
sudo zypper install --no-recommends --no-confirm git
sudo zypper install --no-recommends --no-confirm xwayland
sudo zypper install --no-recommends --no-confirm NetworkManager
sudo zypper install --no-recommends --no-confirm telegram-desktop

sudo rm -rf /etc/{firefox,greetd}
sudo ln -sfn $HOME/dotfiles/{firefox,greetd} /etc

rm -rf $HOME/.config/{alacritty,nvim,git,sway,fuzzel,mako}
ln -sfn $HOME/dotfiles/{alacritty,nvim,git,sway,fuzzel,mako} $HOME/.config

sudo systemctl set-default graphical.target
sudo systemctl enable greetd.service

# fyne
sudo zypper install --no-confirm docker
sudo usermod -G docker -a $USER
sudo zypper install --no-confirm gcc libXcursor-devel libXrandr-devel Mesa-libGL-devel libXi-devel libXinerama-devel libXxf86vm-devel libxkbcommon-devel
go install github.com/fyne-io/fyne-cross@latest

# apply changes
sudo reboot
