#!/usr/bin/env fish

set username "coleman"
set home_dir "/home/$username"
set config_dir "$home_dir/.config"

echo "⏳ Updating system..."
sudo pacman -Syu --noconfirm

echo "📦 Installing packages..."
sudo pacman -S --noconfirm \
  hyprland kitty waybar dolphin sddm fish starship \
  swww neofetch networkmanager network-manager-applet \
  git curl wget btop base-devel unzip jq

echo "🔌 Enabling services..."
sudo systemctl enable NetworkManager
sudo systemctl enable sddm

echo "🌐 Cloning config files..."
cd $home_dir
if not test -d arch-setup
    git clone https://github.com/YOUR_USERNAME/arch-setup.git
end

echo "🧹 Copying .config files..."
cp -r arch-setup/config/* $config_dir

echo "🖼️ Setting wallpaper..."
swww init && swww img $config_dir/Wallpapers/wallhaven-96pzzd.png

echo "🦈 Setting Fish as default shell..."
chsh -s /usr/bin/fish $username

echo "🌟 Setting up Starship prompt..."
mkdir -p $config_dir
cp arch-setup/starship.toml $config_dir/starship.toml

echo "✅ Fixing ownership..."
sudo chown -R $username:$username $home_dir

echo "🎉 Done! Reboot and enjoy your Hyprland setup!"
