# Things to do after a clean install

## PC Speaker

In file `/etc/modprobe.d/nobeep.conf`

```conf
blacklist pcspkr
```

## Backlight

`ls /sys/class/backlight/` will show the name, likely `intel_backlight` or
`acpi_video0`. Replace below accordingly.

Then in file `/etc/udev/rules.d/backlight.rules`

```rules
ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="acpi_video0", GROUP="video", MODE="0664"
```

or for intel:

```rules
RUN+="/bin/chgrp video /sys/class/backlight/intel_backlight/brightness"
RUN+="/bin/chmod g+w /sys/class/backlight/intel_backlight/brightness"
```

## Systemd-boot timeout

In file `/boot/loader/loader.conf`

```conf
timeout 0
```

## Groups

Add your user to these groups:

```bash
sudo usermod -aG audio,video,wheel $USER
```

## Touchpad

In file `/etc/X11/xorg.conf.d/30-touchpad.conf`:

```conf
Section "InputClass"
        Identifier "system-touchpad"
        MatchIsTouchpad "on"
        Option "Tapping" "on"
        Option "ClickMethod" "clickfinger"
        Option "NaturalScrolling" "true"
        Option "ScrollMethod" "twofinger"
EndSection
```

## Traditional network interface names

In file `/boot/loader/entries/<whatever>.conf`, add `net.ifnames=0` at end of
`options` line.

## Locales (add German)

In `/etc/locale.gen` uncomment `de_DE.UTF-8 UTF-8`, then run `sudo locale-gen`

## Run `slock` on suspend

Create file `/etc/systemd/system/slock@.service`

```service
[Unit]
Description=Lock X session using slock for user %i
Before=sleep.target

[Service]
User=%i
Environment=DISPLAY=:0
ExecStartPre=/usr/bin/xset dpms force suspend
ExecStart=/usr/bin/slock

[Install]
WantedBy=sleep.target
```

then run

```bash
sudo systemctl enable slock@$USER.service
```

## Link `sh` to `dash`

Run this once:

```bash
sh_loc="$(which sh)"
sudo rm "$sh_loc"
sudo ln -rs "$(which dash)" "$sh_loc"
```

## Unlock gnome-keyring on login through `ly`

Edit contents of file `/etc/pam.d/ly` to this:

```pam
#%PAM-1.0

auth       include      login
auth       optional     pam_gnome_keyring.so

account    include      login

password   include      login

session    include      login
session    optional     pam_gnome_keyring.so auto_start
```

## Discord allow translucent backgrounds

Replace the line `Exec=/usr/bin/discord` in
`/usr/share/applications/discord.desktop` and other Discord desktop files with
the following:

```desktop
Exec=/usr/bin/discord --enable-blink-features=MiddleClickAutoscroll --use-gl=desktop
```
