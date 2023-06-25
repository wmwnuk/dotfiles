#!/bin/bash

cd /tmp && wget https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.3/Bibata-Modern-Classic.tar.gz
mkdir -p ~/.local/share/{themes,icons}
# mkdir -p ~/.local/share/fonts
cd ~/.local/share/icons && tar xzvf Bibata-Modern-Classic.tar.gz
git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git /tmp/Tokyo-Night-GTK-Theme
cp -r /tmp/Tokyo-Night-GTK-Theme/icons ~/.local/share/
cp -r /tmp/Tokyo-Night-GTK-Theme/themes ~/.local/share/
git clone https://github.com/wmwnuk/oomox-arc-kyotonight.git ~/.local/share/themes/oomox-arc-kyotonight
# cd /tmp/ && wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/SourceCodePro.zip
# cd ~/.local/share/fonts && unzip /tmp/SourceCodePro.zip && wget https://github.com/googlefonts/noto-emoji/blob/main/fonts/NotoColorEmoji.ttf
ln -s ~/.local/share/themes ~/.themes
ln -s ~/.local/share/icons ~/.icons
# ln -s ~/.local/share/fonts ~/.fonts
