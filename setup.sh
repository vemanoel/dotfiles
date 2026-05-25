#!/usr/bin/env sh

sudo zypper refresh
sudo zypper up

rm -rf $HOME/.cache
sudo zypper purge-kernels
sudo zypper clean --all
sudo journalctl --rotate
sudo journalctl --vacuum-time=1s

sudo zypper install --no-confirm --no-recommends android-tools
sudo zypper install --no-confirm --no-recommends git
sudo zypper install --no-confirm --no-recommends NetworkManager
sudo zypper install --no-confirm --no-recommends telegram-desktop
sudo zypper install --no-confirm --no-recommends iosevka-fonts # fonts
sudo zypper install --no-confirm --no-recommends wget # download files
sudo zypper install --no-confirm --no-recommends curl # api testing
sudo zypper install --no-confirm firefox # browser
sudo zypper install --no-confirm --no-recommends htop # process manager
sudo zypper install --no-confirm --no-recommends mpv # video player
sudo zypper install --no-confirm --no-recommends imv # image viewer
sudo zypper install --no-confirm --no-recommends bc # calculator
sudo zypper install --no-confirm --no-recommends make just # task runners
sudo zypper install --no-confirm --no-recommends go gopls # go toolchain
sudo zypper install --no-confirm --no-recommends gh # github cli
sudo zypper install --no-confirm --no-recommends glab # gitlab cli
sudo zypper install --no-confirm --no-recommends grim slurp # take screenshots
sudo zypper install --no-confirm --no-recommends ddcutil # monitor manager
sudo zypper install --no-confirm --no-recommends wireplumber # volume manager
sudo zypper install --no-confirm --no-recommends fuzzel # applications runner
sudo zypper install --no-confirm --no-recommends mako libnotify-tools # notifications manager
sudo zypper addlock patterns-sway-sway; sudo zypper install --no-confirm sway # window manager
sudo zypper install --no-confirm --no-recommends swaybar swaynag swaybg xwayland # window manager dependencies
sudo zypper install --no-confirm --no-recommends greetd tuigreet # session manager
sudo zypper install --no-confirm --no-recommends foot # terminal
sudo zypper install --no-confirm --no-recommends dragon-drop tar zip unzip fdupes # files manager
sudo zypper install --no-confirm --no-recommends helix # code editor

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
  ! -name foot.desktop \
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

rm -rf $HOME/.config/{foot,helix,git,sway,fuzzel,mako}
ln -sfn $HOME/dotfiles/{foot,helix,git,sway,fuzzel,mako} $HOME/.config

ln -sfn $HOME/dotfiles/shell/.* $HOME

sudo systemctl set-default graphical.target
sudo systemctl enable greetd.service

sudo reboot
