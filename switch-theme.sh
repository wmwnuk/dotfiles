#!/bin/sh

DOTFILES=~/Projects/dotfiles

cd $DOTFILES/bin/.local/bin && ln -sf lockscreen-$1 lockscreen             
cd $DOTFILES/dunst/.config/dunst && ln -sf dunstrc-$1 dunstrc           
cd $DOTFILES/env && ln -sf .Xresources-$1 .Xresources                               
cd $DOTFILES/flameshot/.config/flameshot && ln -sf flameshot.ini-$1 flameshot.ini
cd $DOTFILES/i3/.config/i3 && ln -sf bar-and-theme-$1 bar-and-theme           
cd $DOTFILES/i3/.config/i3blocks && ln -sf config-$1 config            
cd $DOTFILES/ide/.config/nvim/lua && ln -sf theme-$1.lua theme.lua        
cd $DOTFILES/rofi/.config/rofi && ln -sf config-$1.rasi config.rasi         
cd $DOTFILES/themes/.config && rm gtk-2.0 && ln -sf gtk-2.0-$1 gtk-2.0                
cd $DOTFILES/themes/.config && rm gtk-3.0 && ln -sf gtk-3.0-$1 gtk-3.0                
cd $DOTFILES/themes/.config && rm gtk-4.0 && ln -sf gtk-4.0-$1 gtk-4.0                
cd $DOTFILES/themes && ln -sf .gtkrc-2.0-$1 .gtkrc-2.0                     
