#!/bin/sh

# Remove layout from US file if present
perl -0777 -i -p -e 's/xkb_symbols "us_de"[\s\S]*?\n};\n?//g' /usr/share/X11/xkb/symbols/us || exit 1

# Add layout to US layout file
echo '' >> /usr/share/X11/xkb/symbols/us || exit 1
wget -O- https://raw.githubusercontent.com/RubixDev/random-linux-stuff/main/US-DE_Keyboard_Layout/layout.c >> /usr/share/X11/xkb/symbols/us || exit 1

# Remove layout from evdev.xml if present
perl -0777 -i -p -e 's/<variant>[\s\S]*?<description>QWERTY with german Umlaut keys<\/description>[\s\S]*?<\/variant>\n?\s*//g' /usr/share/X11/xkb/rules/evdev.xml || exit 1

# Make layout available in system settings
perl -0777 -i -p -e 's/(<layout>[\s\S]*?<description>English \(US\)<\/description>[\s\S]*?<variantList>\n?)(\s*)/\1\2<variant>\n\2  <configItem>\n\2    <name>us_de<\/name>\n\2    <description>QWERTY with german Umlaut keys<\/description>\n\2    <languageList>\n\2      <iso639Id>eng<\/iso639Id>\n\2      <iso639Id>ger<\/iso639Id>\n\2    <\/languageList>\n\2  <\/configItem>\n\2<\/variant>\n\2/g' /usr/share/X11/xkb/rules/evdev.xml || exit 1

# Reload all Layouts
systemctl restart keyboard-setup
udevadm trigger --subsystem-match=input --action=change

