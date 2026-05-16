rm -rf dotfiles-master dotfiles
curl -sSL https://github.com/vemanoel/dotfiles/archive/refs/heads/main.zip
unzip main.zip
rm main.zip
mv dotfiles-master dotfiles
chmod +x dotfiles/setup.sh
./dotfiles/setup.sh
