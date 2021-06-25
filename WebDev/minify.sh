#!/bin/bash

minify --version > /dev/null || {
    echo -e "\033[1;33mminify not found. Trying to install...\033[0m"
    sudo npm i -g minify || {
        echo -e "\033[1;33mnpm not found. Trying to install...\033[0m"
        sudo pacman -S nodejs npm || {
            sudo apt install nodejs npm || {
                echo -e "\033[1;31mnpm is not and could not be installed!\033[0m"
                exit 1
            }
        }
        sudo npm i -g minify || {
            echo -e "\033[1;31mminify is not and could not be installed!\033[0m"
            exit 1
        }
    }
}

command -v inotifywait > /dev/null || {
    echo -e "\033[1;33minotify-tools not found. Trying to install...\033[0m"
    sudo pacman -S inotify-tools || {
        sudo apt install inotify-tools || {
            echo -e "\033[1;31minotify-tools is not and could not be installed!\033[0m"
            exit 1
        }
    }
}

minifyFile () {
    if [ -z "$1" ]; then
        echo -e "\033[31mminifyFile: no file was specified\033[0m"
        return 1
    fi

    file="$1"
    out="min${file:3}"
    echo -e "\033[36mMinifying $file to $out\033[0m"
    mkdir -p "${out%/*}"
    minify "$file" > "$out"
}

inotifywait -m src -r -e create -e moved_to -e close_write | {
    while read path action file; do
        if [[ "$file" =~ .*\.(html|css|js)$ ]]; then
            minifyFile "$path$file"
        fi
    done
}
