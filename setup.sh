#!/usr/bin/env sh

sudo zypper refresh
sudo zypper up

sudo zypper addrepo https://brave-browser-rpm-nightly.s3.brave.com/brave-browser-nightly.repo
sudo zypper --gpg-auto-import-keys refresh
sudo zypper install --no-confirm --no-recommends brave-origin-nightly

sudo zypper install --no-confirm --no-recommends android-tools
sudo zypper install --no-confirm --no-recommends git
sudo zypper install --no-confirm --no-recommends NetworkManager
sudo zypper install --no-confirm --no-recommends telegram-desktop
sudo zypper install --no-confirm --no-recommends dejavu-fonts liberation-fonts iosevka-fonts
sudo zypper install --no-confirm --no-recommends yazi dragon-drop file p7zip wl-clipboard
sudo zypper install --no-confirm --no-recommends curl wget
sudo zypper install --no-confirm --no-recommends htop
sudo zypper install --no-confirm --no-recommends mpv imv
sudo zypper install --no-confirm --no-recommends bc
sudo zypper install --no-confirm --no-recommends make just
sudo zypper install --no-confirm --no-recommends go gopls
sudo zypper install --no-confirm --no-recommends gh glab
sudo zypper install --no-confirm --no-recommends grim slurp
sudo zypper install --no-confirm --no-recommends ddcutil
sudo zypper install --no-confirm wireplumber
sudo zypper install --no-confirm --no-recommends fuzzel
sudo zypper install --no-confirm --no-recommends mako libnotify-tools
sudo zypper install --no-confirm --no-recommends sway swaybar swaynag swaybg xwayland xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-wlr
sudo zypper install --no-confirm --no-recommends greetd tuigreet
sudo zypper install --no-confirm --no-recommends foot
sudo zypper install --no-confirm --no-recommends tar zip unzip fdupes
sudo zypper install --no-confirm --no-recommends helix

sudo zypper install --no-confirm --no-recommends zstd libXtst6 libgthread-2_0-0 libxcb-xinerama0 libglib-2_0-0 libxcb-cursor0 mozilla-nss libxcb-icccm4 libxcb-keysyms1 xdg-utils
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
  ! -name brave-origin-nightly.desktop \
  ! -name helix.desktop \
-exec sh -c '
  if grep -q "^NoDisplay=" "$1"; then
    sed -i "s/^NoDisplay=.*/NoDisplay=true/" "$1"
  else
    echo "NoDisplay=true" >> "$1"
  fi
' sh {} \;

find $HOME/dotfiles -exec chmod +x {} +

sudo mkdir -p /etc
sudo rm -rf /etc/{firefox,brave,greetd}
sudo ln -sf $HOME/dotfiles/{firefox,brave,greetd} /etc

rm -rf $HOME/.config/{foot,helix,git,sway,fuzzel,mako}
ln -sfn $HOME/dotfiles/{foot,helix,git,sway,fuzzel,mako,yazi} $HOME/.config

ln -sfn $HOME/dotfiles/shell/.* $HOME

sudo systemctl set-default graphical.target
sudo systemctl enable greetd.service

rm -rf $HOME/.cache
sudo zypper purge-kernels
sudo zypper clean --all
sudo journalctl --rotate
sudo journalctl --vacuum-time=1s

sudo reboot
