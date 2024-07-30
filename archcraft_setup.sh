#!/bin/bash

display_welcome_message(){
  echo ------------------------------
  echo Archcraft quick setup script
  echo by WeeXnes
  echo ------------------------------
}

snap_download(){
  git clone https://aur.archlinux.org/snapd.git
  cd snapd
  makepkg -si
  sudo systemctl enable --now snapd.socket
  sudo systemctl enable --now snapd.apparmor.service
  cd ..
}

install_packages_mandatory(){
  sudo pacman -S wget go base-devel playerctl
}

install_packages_optional(){
  sudo pacman -S steam discord spotify-launcher
}

dotnet_download(){
  echo downloading dotnet
  wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
  chmod +x ./dotnet-install.sh
  ./dotnet-install.sh --version latest
}

archcraft_patches(){
  echo downloading patches
  git clone https://github.com/WeeXnes/archcraft_patches.git
  cd archcraft_patches/
  ./build.sh
  # Select which patches you want to apply
  build/fix_oled_screen_brightness
  build/fix_mediactl
  # Needs sudo due to modifying protected files
  sudo build/fix_intel_xe_renderer
  cd ..
}

secure_boot () {
  echo enabling secureboot...
  wget https://gist.githubusercontent.com/WeeXnes/97768d9d0a94696d83342d6cfb9018e2/raw/f4c976cedfbc7d31ff3d69ff9f2481ed2dabf8ef/secureboot_installer.sh -O secureboot_installer.sh
  chmod +x ./secureboot_installer.sh
  ./secureboot_installer.sh
}

rust_download(){
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

nodejs_download(){
  # installs nvm (Node Version Manager)
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  # download and install Node.js (you may need to restart the terminal)
  nvm install 20
  echo ------------------------
  echo if nvm install did not work, run it manually after restarting the terminal
  echo ------------------------
  # verifies the right Node.js version is in the environment
  node -v # should print `v20.16.0`
  # verifies the right npm version is in the environment
  npm -v # should print `10.8.1`
}

btop_download(){
  sudo snap install btop
}
rquickshare_download(){
  wget https://github.com/Martichou/rquickshare/releases/download/v0.10.2/r-quick-share_0.10.2_amd64.snap -O rquickshare.snap
  snap install --dangerous rquickshare.snap
}
gaming_meta(){
  yay arch-gaming-meta
}



display_welcome_message
install_packages_mandatory
install_packages_optional
snap_download
dotnet_download
archcraft_patches
rust_download
nodejs_download
btop_download
rquickshare_download
#gaming_meta
#secure_boot