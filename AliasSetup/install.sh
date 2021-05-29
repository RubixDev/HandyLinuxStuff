#!/bin/bash

add_alias() { echo -e "alias $1" >> ~/.zshrc; }

add_alias "tmux='tmux -2'"
add_alias "zalias='vim ~/.zshrc'"
add_alias "setclip='xclip -selection c'"
add_alias "getclip='xclip -selection c -o'"
add_alias "con='ssh contabo'"
add_alias "poof='poweroff'"
add_alias "btop='bpytop'"
add_alias "cp='cp -iv'"
add_alias "myip='curl ipinfo.io/ip'"
add_alias "rr='rm -r'"
add_alias "lelcat='bash -c \"\$(wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/meow.sh)\"'"
