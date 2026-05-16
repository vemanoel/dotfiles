sudo zypper install --no-confirm firefox htop mpv imv bc telegram-desktop wezterm NetworkManager tar zip unzip fdupes
sudo zypper install --no-confirm git neovim make go gopls gh glab curl
sudo zypper install --no-confirm iosevka-fonts

sudo zypper install --no-confirm sway swaybg mako grim slurp fuzzel libnotify-tools

sudo zypper install --no-confirm docker
sudo usermod -G docker -a $USER
sudo zypper install --no-confirm gcc android-tools libXcursor-devel libXrandr-devel Mesa-libGL-devel libXi-devel libXinerama-devel libXxf86vm-devel libxkbcommon-devel
go install fyne.io/tools/cmd/fyne@latest
go install github.com/fyne-io/fyne-cross@latest
