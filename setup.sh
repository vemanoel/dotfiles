#!/usr/bin/env sh

sudo zypper install --no-confirm wget # download files
sudo zypper install --no-confirm curl # api testing
sudo zypper install --no-confirm firefox # browser
sudo zypper install --no-confirm iosevka-fonts # default font
sudo zypper install --no-confirm htop # process manager
sudo zypper install --no-confirm mpv # video player
sudo zypper install --no-confirm imv # image viewer
sudo zypper install --no-confirm bc # calculator
sudo zypper install --no-confirm make just # task runners
sudo zypper install --no-confirm dragon-drop tar zip unzip fdupes # files manager
sudo zypper install --no-confirm go gopls # go toolchain
sudo zypper install --no-confirm gh # github cli
sudo zypper install --no-confirm glab # gitlab cli
sudo zypper install --no-confirm NetworkManager
sudo zypper install --no-confirm telegram-desktop

# git
sudo zypper install --no-confirm git
rm -rf $HOME/.config/git
ln -sfn $HOME/dotfiles/git $HOME/.config/git

# code editor
sudo zypper install --no-confirm neovim

# terminal
sudo zypper install --no-confirm wezterm

# window manager
sudo zypper install --no-confirm sway swaylock swayidle swaybg
sudo zypper install --no-confirm grim slurp # take screenshots
sudo zypper install --no-confirm mako libnotify-tools # notifications manager
sudo zypper install --no-confirm fuzzel # applications runner
rm -rf $HOME/.config/{sway,fuzzel,mako}
ln -sfn $HOME/dotfiles/{sway,fuzzel,mako} $HOME/.config
find $HOME/dotfiles/sway/scripts -exec chmod +x {} +

# session manager
sudo zypper install --no-confirm greetd tuigreet
sudo rm -rf /etc/greetd
sudo ln -sfn $HOME/dotfiles/greetd /etc/greetd
sudo systemctl set-default graphical.target
sudo systemctl enable greetd.service

# fyne
sudo zypper install --no-confirm docker
sudo usermod -G docker -a $USER
sudo zypper install --no-confirm gcc android-tools libXcursor-devel libXrandr-devel Mesa-libGL-devel libXi-devel libXinerama-devel libXxf86vm-devel libxkbcommon-devel
go install fyne.io/tools/cmd/fyne@latest
go install github.com/fyne-io/fyne-cross@latest

# apply changes
sudo reboot
