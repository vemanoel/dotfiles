rm -rf dotfiles-master dotfiles
curl -sSL https://github.com/vcitoremanoel123/dotfiles/archive/refs/heads/main.zip -o main.zip
unzip main.zip
rm main.zip
mv dotfiles-main dotfiles
chmod +x dotfiles/setup.sh
./dotfiles/setup.sh
