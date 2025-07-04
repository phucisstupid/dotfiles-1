# Packages
echo "Installing Dependencies"
brew install lua switchaudio-osx nowplaying-cli
brew tap FelixKratz/formulae
brew install sketchybar

# Fonts
brew install --cask sf-symbols font-sketchybar-app-font font-sf-mono font-sf-pro

# Get latest icon_map.lua
latest_tag=$(curl -s https://api.github.com/repos/kvndrsslr/sketchybar-app-font/releases/latest | grep '"tag_name":' | cut -d '"' -f 4)
font_url="https://github.com/kvndrsslr/sketchybar-app-font/releases/download/${latest_tag}/icon_map.lua"
output_path="$CONFIG_DIR/sketchybar/helpers/icon_map.lua"
mkdir -p "$(dirname "$output_path")"
curl -L "$font_url" -o "$output_path"

# SbarLua
(git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)

echo "Cloning Config"
git clone https://github.com/FelixKratz/dotfiles.git /tmp/dotfiles
mv $HOME/.config/sketchybar $HOME/.config/sketchybar_backup
mv /tmp/dotfiles/.config/sketchybar $HOME/.config/sketchybar
rm -rf /tmp/dotfiles

brew services restart sketchybar
sketchybar --reload

