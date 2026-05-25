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

sudo zypper install --no-confirm libgthread-2_0-0 libxcb-xinerama0 libglib-2_0-0 libxcb-cursor0 mozilla-nss libxcb-icccm4 libxcb-keysyms1 xdg-utils
[ -x /usr/local/bin/uninstall-anki ] && sudo /usr/local/bin/uninstall-anki
rm -rf $HOME/.local/share/{Anki,Anki2,AnkiProgramFiles}
rm -rf $HOME/.cache/{Anki2,AnkiProgramFiles}
ANKI_SETUP=$(mktemp -d); cd $ANKI_SETUP; trap 'rm -rf $ANKI_SETUP' EXIT
curl -fsSLo releases.json 'https://api.github.com/repos/ankitects/anki/releases?per_page=100'
ASSET_URL=$(jq -r '[.[] | select(.draft == false and .prerelease == false) | .assets[]? | select(.name | test("linux.*\\.tar\\.zst$"))] | first.browser_download_url' releases.json)
curl -fsSLo anki-launcher.tar.zst $ASSET_URL
tar xaf anki-launcher.tar.zst
cd anki-launcher-*
sudo mv -f uninstall.sh /usr/local/bin/uninstall-anki
sudo ./install.sh

sudo find /usr/share/applications \
  -type f -name "*.desktop" \
  ! -name org.alacritty.Alacritty.desktop \
  ! -name org.telegram.desktop.desktop \
  ! -name htop.desktop \
  ! -name firefox.desktop \
  ! -name helix.desktop \
-exec sh -c '
  if grep -q "^NoDisplay=" "$1"; then
    sed -i "s/^NoDisplay=.*/NoDisplay=true/" "$1"
  else
    echo "NoDisplay=true" >> "$1"
  fi
' sh {} \;

find $HOME/dotfiles -exec chmod +x {} +

sudo rm -rf /etc/{firefox,greetd}
sudo ln -sfn $HOME/dotfiles/{firefox,greetd} /etc

rm -rf $HOME/.config/{alacritty,helix,git,sway,fuzzel,mako}
ln -sfn $HOME/dotfiles/{alacritty,helix,git,sway,fuzzel,mako} $HOME/.config

ln -sfn $HOME/dotfiles/shell/.* $HOME

sudo systemctl set-default graphical.target
sudo systemctl enable greetd.service

sudo zypper clean --all
sudo journalctl --vacuum-time=1d

sudo reboot
