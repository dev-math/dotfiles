# @dev-math dotfiles
These files configure my environment

Table of contents:
- [Workflow](workflow)
- [Screenshots](screenshots)
- [Setup (Script)](setup-(script))
- [Setup (Manual)](setup-(manual))
  - [Dependencies](dependencies)
    - [AUR](aur-packages-(install-before-proceeding))
    - [Arch packages](arch-packages-(install-before-proceeding))
  - [Config](setting-up-everything:)
    - [Fonts](install-fonts)
    - [i3-gaps](i3-gaps)
    - [Polybar](polybar)
    - [Kitty](kitty)
    - [Neovim](neovim)
    - [Picom](picom)
    - [Pywal](pywal)
    - [Take your terminal to the next level](take-your-terminal-to-the-next-level)
    - [Notifications](notifications)
    - [Spotify](spotify-(spicetify)-theme)
    - [Display Manager](display-manager-config)
    - [Scripts](scripts)
    - [Wallpapers](wallpapers)
    - [GTK](gtk-and-icons-theme)
    - [Tips](tips)
- [Credits](credits)

## Workflow

<img src="https://i.imgur.com/K9PBtBv.png" alt="img" align="right" width="400px">

- **OS:** [Arch Linux](https://archlinux.org/)
- **WM:** [i3-gaps](https://github.com/Airblader/i3), [AwesomeWM](https://github.com/awesomeWM/awesome/) <kbd>deprecated</kbd>
- **Shell:** [Zsh (Z shell)](http://zsh.sourceforge.net/) with [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) framework and [Spaceship](https://github.com/spaceship-prompt/spaceship-prompt/) theme
- **Terminal:** [kitty](https://github.com/kovidgoyal/kitty/), [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html) <kbd>deprecated</kbd>
- **Editor**: [Neovim](https://github.com/neovim/neovim/)
- **Terminal font:** SF Mono
- **File Manager**: [Thunar](https://git.xfce.org/xfce/thunar/)
- **Launcher**: [rofi](https://github.com/davatorium/rofi/)
- **Browser**: [Brave]()

## Screenshots
![](https://i.imgur.com/bEVQdEy.jpg)
![](https://i.imgur.com/x1aITlL.jpeg)
![](https://i.imgur.com/K9PBtBv.png)
![](https://i.imgur.com/L5K6JDZ.png)
![](https://i.imgur.com/f70oJPP.png)
![](https://i.imgur.com/gxYPLLg.png)
![](https://i.imgur.com/BR3UZqy.jpeg)
![](https://i.imgur.com/HFlu5a2.jpeg)

---

## Setup (Script)
This is the script I use in a clean ArchLinux install to set up my system.

```sh
git clone https://github.com/dev-math/dotfiles.git
cd dotfiles
./bin/install.sh
```

## Setup (Manual) 
First of all make sure you at least have these packages:
```sh
sudo pacman -Syu --noconfirm --needed base-devel git wget xdg-user-dirs
```

Then run:

```xdg-user-dir```

### Dependencies

#### AUR packages (install before proceeding)

<details><summary>Details</summary>

* [asdf-vm](https://aur.archlinux.org/packages/asdf-vm/) - Extendable version manager with support for Ruby, Node.js, Elixir, Erlang & more
* [brave-bin](https://aur.archlinux.org/packages/brave-bin) - Web browser that blocks ads and trackers by default (binary release)
  * [gotop-bin](https://aur.archlinux.org/packages/gotop-bin) - A terminal based graphical activity monitor inspired by gtop and vtop
* [i3lock-color-git](https://aur.archlinux.org/packages/i3lock-color-git/) - An improved screenlocker based upon XCB and PAM with color configuration support
* [kdeconnect-git](https://aur.archlinux.org/packages/kdeconnect-git/) - KDE Connect is a multi-platform app that allows your devices to communicate
* [notify-send-py](https://aur.archlinux.org/notify-send-py.git) - A python script for sending desktop notifications from the shell
* [papirus-icon-theme-git](https://aur.archlinux.org/papirus-icon-theme-git.git) - A free and open source SVG icon theme based on Paper Icon Set
* [polybar](https://aur.archlinux.org/packages/polybar) - A fast and easy-to-use status bar
* [spicetify-cli](https://aur.archlinux.org/packages/spicetify-cli) - Command-line tool to customize Spotify client
Read the wiki [Installation spicetify-cli]
* [spotify](https://aur.archlinux.org/packages/spotify) - A proprietary music streaming service
* [visual-studio-code-bin](https://aur.archlinux.org/packages/visual-studio-code-bin) - Visual Studio Code (vscode): Editor for building and debugging modern web and cloud applications (official binary version)
* [wpgtk](https://aur.archlinux.org/packages/wpgtk) - A gui wallpaper chooser that changes your WM theme, GTK theme and more

</details>

You can easily install it by typing: 

```sh
yay -S asdf-vm brave-bin gotop-bin i3lock-color-git kdeconnect-git notify-send-py papirus-icon-theme-git polybar spicetify-cli spotify visual-studio-code-bin wpgtk --needed
```
in your terminal (Yay required)

* [yay](https://aur.archlinux.org/packages/yay) - Yet another yogurt. Pacman wrapper and AUR helper written in go.

#### Arch packages (install before proceeding)

<details><summary>Details</summary>

* [discord](https://archlinux.org/packages/community/x86_64/discord/) - All-in-one voice and text chat for gamers that's free and secure.
* [eog](https://archlinux.org/packages/extra/x86_64/eog/) - Eye of Gnome: An image viewing and cataloging program
* [feh](https://archlinux.org/packages/extra/x86_64/feh/) - Fast and light imlib2-based image viewer  
* [kitty](https://archlinux.org/packages/community/x86_64/kitty/) - A modern, hackable, featureful, OpenGL-based terminal emulator
* [maim](https://archlinux.org/packages/community/x86_64/maim/) - Utility to take a screenshot using imlib2
* [man-db](https://archlinux.org/packages/core/x86_64/man-db/) - A utility for reading man pages 
* [man-pages](https://archlinux.org/packages/core/any/man-pages/) - Linux man pages
* [neovim](https://archlinux.org/packages/community/x86_64/neovim/) - Fork of Vim aiming to improve user experience, plugins, and GUIs
* [neofetch](https://archlinux.org/packages/community/any/neofetch/) - A CLI system information tool written in BASH that supports displaying images.
* [networkmanager](https://archlinux.org/packages/extra/x86_64/networkmanager/) - Network connection manager and user applications
* [noto-fonts](https://archlinux.org/packages/extra/any/noto-fonts/) - Google Noto TTF fonts
* [noto-fonts-cjk](https://archlinux.org/packages/extra/any/noto-fonts-cjk/) - Google Noto CJK fonts
* [noto-fonts-emoji](https://archlinux.org/packages/extra/any/noto-fonts-emoji/) - Google Noto emoji fonts
* [noto-fonts-extra](https://archlinux.org/packages/extra/any/noto-fonts-extra/) - Google Noto TTF fonts - additional variants
* [pavucontrol](https://archlinux.org/packages/extra/x86_64/pavucontrol/) - PulseAudio Volume Control
* [perl-file-mimeinfo](https://archlinux.org/packages/extra/any/perl-file-mimeinfo/) - Determine file type, includes mimeopen and mimetype
* [picom](https://archlinux.org/packages/community/x86_64/picom/) - X compositor that may fix tearing issues
* [playerctl](https://archlinux.org/packages/community/x86_64/playerctl/) - mpris media player controller and lib for spotify, vlc, audacious, bmp, xmms2, and others.
* [pulseaudio](https://archlinux.org/packages/extra/x86_64/pulseaudio/) - A featureful, general-purpose sound server
* [pulseaudio-alsa](https://archlinux.org/packages/extra/x86_64/pulseaudio-alsa/) - ALSA Configuration for PulseAudio
* [python-pip](https://archlinux.org/packages/extra/any/python-pip/) - The PyPA recommended tool for installing Python packages
* [python-pywal](https://archlinux.org/packages/community/any/python-pywal/) - Generate and change colorschemes on the fly
* [python-gobject](https://archlinux.org/packages/extra/x86_64/python-gobject/) - Python Bindings for GLib/GObject/GIO/GTK+
* [qt5-tools](https://archlinux.org/packages/extra/x86_64/qt5-tools/) - A cross-platform application and UI framework (Development Tools, QtHelp)
* [rofi](https://archlinux.org/packages/community/x86_64/rofi/) - A window switcher, application launcher and dmenu replacement
* [sshfs](https://archlinux.org/packages/community/x86_64/sshfs/) - FUSE client based on the SSH File Transfer Protocol
* [sudo](https://archlinux.org/packages/core/x86_64/sudo/) - Give certain users the ability to run some commands as root
* [texinfo](https://archlinux.org/packages/core/x86_64/texinfo/) - GNU documentation system for on-line information and printed output
* [thunar-archive-plugin](https://archlinux.org/packages/extra/x86_64/thunar-archive-plugin/) - Create and extract archives in Thunar
* [thunar](https://archlinux.org/packages/extra/x86_64/thunar/) - Modern file manager for Xfce
* [thunar-media-tags-plugin](https://archlinux.org/packages/extra/x86_64/thunar-media-tags-plugin/) - Adds special features for media files to the Thunar File Manager
* [thunar-volman](https://archlinux.org/packages/extra/x86_64/thunar-volman/) - Automatic management of removeable devices in Thunar
* [unzip](https://archlinux.org/packages/extra/x86_64/unzip/) - For extracting and viewing files in .zip archives
* [xclip](https://archlinux.org/packages/extra/x86_64/xclip/) - Command line interface to the X11 clipboard
* [xdg-utils](https://archlinux.org/packages/extra/any/xdg-utils/) - Command line tools that assist applications with a variety of desktop integration tasks
* [xorg-server](https://archlinux.org/packages/extra/x86_64/xorg-server/) - Xorg X server
* [xorg-xinit](https://archlinux.org/packages/extra/x86_64/xorg-xinit/) - X.Org initialisation program
* [xorg-xprop](https://archlinux.org/packages/extra/x86_64/xorg-xprop/) - Property displayer for X
* [xorg-xrdb](https://archlinux.org/packages/extra/x86_64/xorg-xrdb/) - X server resource database utility
* [xournalpp](https://archlinux.org/packages/community/x86_64/xournalpp/) - Handwriting notetaking software with PDF annotation support
* [xsettingsd](https://archlinux.org/packages/community/x86_64/xsettingsd/) - Provides settings to X11 applications via the XSETTINGS specification
* [zathura](https://archlinux.org/packages/community/x86_64/zathura/) - Minimalistic document viewer
* [zathura-cb](https://archlinux.org/packages/community/x86_64/zathura-cb/) - Adds comic book support to zathura
* [zathura-djvu](https://archlinux.org/packages/community/x86_64/zathura-djvu/) - DjVu support for Zathura
* [zathura-pdf-mupdf](https://archlinux.org/packages/community/x86_64/zathura-pdf-mupdf/) - PDF support for Zathura (MuPDF backend) (Supports PDF, ePub, and OpenXPS)
* [zathura-ps](https://archlinux.org/packages/community/x86_64/zathura-ps/) - Adds ps support to zathura by using the libspectre library
* [zip](https://archlinux.org/packages/extra/x86_64/zip/) - Compressor/archiver for creating and modifying zipfiles
* [zsh](https://archlinux.org/packages/extra/x86_64/zsh/) - A very advanced and programmable command interpreter (shell) for UNIX
* [zsh-completions](https://archlinux.org/packages/community/any/zsh-completions/) - Additional completion definitions for Zsh


</details>

You can install all this pkgs by pasting

```sh
pacman -S discord eog feh kitty maim man-db man-pages neovim neofetch networkmanager noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra pavucontrol perl-file-mimeinfo picom playerctl pulseaudio pulseaudio-alsa python-pip python-pywal python-gobject qt5-tools rofi sshfs sudo texinfo thunar-archive-plugin thunar thunar-media-tags-plugin thunar-volman unzip xclip xdg-utils xorg-server xorg-xinit xorg-xprop xorg-xrdb xournalpp xsettingsd zathura zathura-cb zathura-djvu zathura-pdf-mupdf zathura-ps zip zsh zsh-completions --needed
```
in your terminal

### Setting up everything:

First clone this repo and cd in the directory

```sh
git clone https://github.com/dev-math/dotfiles.git
cd dotfiles
```

#### Install fonts
```sh
mkdir -p ~/.local/share/fonts
cp -r ./misc/fonts/* ~/.local/share/fonts/
fc-cache -v
```

#### i3-gaps
```sh
[ -e ~/.config/i3 ] && mv ~/.config/i3 ~/.config/i3-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
cp -r config/i3 ~/.config/
```

#### Polybar
```sh
[ -e ~/.config/polybar ] && mv ~/.config/polybar ~/.config/polybar-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
cp -r config/polybar ~/.config/
```

#### Kitty
```sh
[ -e ~/.config/kitty ] && mv ~/.config/kitty ~/.config/kitty-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
cp -r config/kitty ~/.config/kitty
```

#### Neovim
```sh
[ -e ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
cp -r config/nvim ~/.config/nvim
```

#### Picom
```sh
[ -e ~/.config/picom.conf ] && mv ~/.config/picom.conf ~/.config/picom-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
cp -r config/picom.conf ~/.config/picom.conf
```

#### Pywal
```sh
mkdir -p ~/.config/wal/templates
cp -r config/wal/templates/* ~/.config/wal/templates/
wal -i ~/Pictures/wallpapers # run wal to gen cache files
# Symlink pywal files
ln -sf ~/.cache/wal/.Xresources ~/ 
mkdir -p ~/.config/zathura
ln -sf ~/.cache/wal/zathurarc ~/.config/zathura/
chmod +x ~/.cache/wal/lock*
ln -sf ~/.cache/wal/lock-alpha.sh ~/.local/bin/lockscreen
```

#### Take your terminal to the next level
Install oh-my-zsh:

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
Problems? Refer to [oh-my-zsh GitHub page](https://github.com/ohmyzsh/ohmyzsh)

Install spaceship theme:

```sh
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```

Install Zinit

```sh
sh -c "$(curl -fsSL https://git.io/zinit-install)"
```

Replace your .zshrc file with mine and change your shell to ZSH

```sh
cp -r path/to/dev-math/.zshrc ~/.zshrc
chsh -s $(which zsh) 
```

#### Notifications
By default you will be using xfce4-notifyd, but if you want to use Dunst:

```sh
sudo pacman -S dunst
mkdir -p ~/.config/dunst
[ -e ~/.config/dunst/dunstrc ] && mv ~/.config/dunst/dunstrc ~/.config/dunst/dunstrc-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
ln -sf ~/.cache/wal/dunstrc ~/.config/dunst/dunstrc # Yes you will need my pywal config
sudo pacman -R xfce4-notifyd
```

Obs.: Maybe you will need to restart the computer.

Obs.²: If xfce4-Noticed is not displaying notifications make sure it is running. I start it in my .xprofile with this line:

```sh
/usr/lib/xfce4/notifyd/xfce4-notifyd &
```

#### Spotify (Spicetify) theme

Open spotify for the first time

```sh
mkdir -p ~/.config/spicetify/Themes/DribbblishPywal
mkdir -p ~/.config/spicetify/Extensions
cp -r config/spicetify/Themes/DribbblishPywal/* ~/.config/spicetify/Themes/DribbblishPywal
mv ~/.config/spicetify/Themes/DribbblishPywal/dribbblish.js ~/.config/spicetify/Extensions/dribbblish.js
spicetify config extensions dribbblish.js
spicetify config current_theme DribbblishPywal
spicetify config current_theme DribbblishPywal color_scheme base
spicetify config inject_css 1 replace_colors 1 overwrite_assets 1
```

#### Display Manager config 

<details><summary>xinitrc</summary>

```sh
[ -e ~/.xprofile ] && mv ~/.xprofile ~/.xprofile-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
cp -r .xprofile ~/.xprofile
[ -e ~/.xinitrc ] && mv ~/.xinitrc ~/.xinitrc-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
cp -r .xinitrc ~/.xinitrc
```

Just run `startx` on tty and done.

Obs.: Add programs to autostart on ~/.xprofile

Tip: Maybe this is useful https://wiki.archlinux.org/title/Xinit#Autostart_X_at_login

</details>

<details><summary>LightDM</summary>

Run:

```sh
yay -S --noconfirm --needed lightdm lightdm-webkit2-greeter lightdm-webkit2-theme-glorious # yes you will need yay
systemctl enable lightdm
```

* edit `/etc/lightdm/lightdm.conf` and set `greeter-session=lightdm-webkit2-greeter` .
* Then edit `/etc/lightdm/lightdm-webkit.conf` and set `theme` or `webkit-theme` to `glorious` .

</details>

#### Scripts

```sh
mkdir -p ~/.local/bin
cp -r bin/* ~/.local/bin/
mkdir -p ~/Pictures/screenshots # Create the screenshot folder for the screenshot script to work
```

#### Wallpapers

```sh
mkdir -p ~/Pictures/wallpapers
cp -r misc/wallpapers/* ~/Pictures/wallpapers
```

#### GTK and icons theme

```sh
mv ~/.gtkrc-2.0 ~/.config/.gtkrc-2.0-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
cp -r .gtkrc-2.0 ~/.gtkrc-2.0
mv ~/.config/gtk-3.0 ~/.config/gtk-3.0-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
cp -r config/gtk-3.0 ~/.config/gtk-3.0
```

Set the chosen theme with the lxappearance (`sudo pacman -S lxappearance`) or edit the gtk files.


<details><summary>WhiteSur</summary>

GTK theme:

```sh
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
cd WhiteSur-gtk-theme 
./install.sh
cd ..
rm -Rf WhiteSur-gtk-theme
```

Icon theme: 

```sh
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme 
./install.sh
cd ..
rm -Rf WhiteSur-icon-theme
```

</details>

<details><summary>Pywal theme</summary>

Run:

```sh
# Install GTK template on wpgtk
wpg-install.sh -g
# Install Icon template on wpgtk
wpg-install.sh -i
# wpgtk config file
[ -e ~/.config/wpg/wpg.conf ] && mv ~/.config/wpg.conf ~/.config/wpg-backup-"$(date +%Y.%m.%d-%H.%M.%S)" # Backup current configuration
mkdir -p ~/.config/wpg
cp -r config/wpg/wpg.conf ~/.config/wpg/wpg.conf
```

For live reload:
* create the file (if not exist) `~/.xsettingsd` and add this line `Net/ThemeName "FlatColor"` .
* Then edit `~/.local/bin/afterwal` and uncomment this line `timeout 0.5s xsettingsd` .

Obs.: you might need to use wpgtk to generate a theme from an image, but only the first time

</details>

#### Tips

- Disable PC Speaker

  Create the file `/etc/modprobe.d/nobeep.conf` and add this line `blacklist pcspkr`

- Start NetworkManager on boot

  `sudo systemctl enable NetworkManager.service`

---

## Credits
- [NoSleep](https://github.com/morpheusthewhite/spicetify-themes/tree/master/NoSleep)
- [Elementary](https://github.com/morpheusthewhite/spicetify-themes/tree/master/Elementary)
- [Elenapan dotfiles](https://github.com/elenapan/dotfiles)
- [Shining Plum](https://github.com/jazz-g/shining-plum)
- [GideonWolfe Chamaleon](https://github.com/GideonWolfe/Chameleon)
- [pascalwhoop dotfiles](https://github.com/pascalwhoop/dotfiles)
- [GideonWolfe dotfiles](https://github.com/GideonWolfe/dots)
- [muppetcode dotfiles](https://github.com/muppetcode/dotfiles)
- [adi1090x polybar themes](https://github.com/adi1090x/polybar-themes)
- [haideralipunjabi KDEConnect module for Polybar](https://github.com/haideralipunjabi/polybar-kdeconnect)
- [ilsenatorov Dotfiles](https://github.com/ilsenatorov/dotfiles)
- [adi1090x rofi themes](https://github.com/adi1090x/rofi/)
- [SwiftyChicken dotfiles](https://github.com/SwiftyChicken/dotfiles)
- [obliviousofcraps mf-dots](https://github.com/obliviousofcraps/mf-dots)
- [ilham25 aether dotfiles](https://github.com/ilham25/dotfiles-openbox)
- [jrodal98 screenshot-actions](https://github.com/jrodal98/screenshot-actions)
- [Zolyn night mode script](https://github.com/Zolyn/dotfiles/blob/master/scripts/night_mode_toggle.sh)
- [nvim-lua neovim starter config](https://github.com/nvim-lua/kickstart.nvim)
