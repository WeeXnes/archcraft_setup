

gaming_meta(){
  yay arch-gaming-meta
}

archcraft_patches(){
  echo downloading cachyos repo patch
  git clone https://github.com/WeeXnes/archcraft_patches.git cachyrepopatch
  cd cachyrepopatch/
  ./build.sh
  # Needs sudo due to modifying protected files
  sudo build/fix_cachyos_repo
  cd ..
}


wget https://mirror.cachyos.org/cachyos-repo.tar.xz
tar xvf cachyos-repo.tar.xz && cd cachyos-repo
echo "---------------------------------------------------------"
read -p "When asked to install/update packages, please deny"
sudo ./cachyos-repo.sh
archcraft_patches
sudo pacman -Syu
sudo pacman -S linux-cachyos-eevdf linux-cachyos-eevdf-headers
read -p "install gaming package from the AUR (y/n)?" CONT
if [ "$CONT" = "y" ]; then
  echo "installing gaming meta from AUR..."
  gaming_meta
fi
