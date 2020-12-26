# dotfiles
These files configure my environment

### Setup
- **OS** [Arch Linux](https://archlinux.org/)
- **WM** [i3-gaps](https://github.com/Airblader/i3) (old)
- **WM** [AwesomeWM](https://github.com/awesomeWM/awesome/) (current)
- **Shell** [Zsh (Z shell)](http://zsh.sourceforge.net/)
- **Terminal** [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html)
- **Terminal font** [Hack](https://github.com/source-foundry/Hack)

### AUR packages (install before proceeding)
* [awesome-git](https://aur.archlinux.org/packages/awesome-git) - Highly configurable framework window manager
* [betterdiscord](https://aur.archlinux.org/packages/betterdiscord) - Discord extension that introduces new features like BTTV emotes and plugin support.
* [gotop-bin](https://aur.archlinux.org/packages/gotop-bin) - A terminal based graphical activity monitor inspired by gtop and vtop
* [i3lock-color-git](https://aur.archlinux.org/packages/i3lock-color-git/) - An improved screenlocker based upon XCB and PAM with color configuration support
* [kdeconnect-git](https://aur.archlinux.org/packages/kdeconnect-git/) - KDE Connect is a multi-platform app that allows your devices to communicate
* [light-git](https://aur.archlinux.org/packages/light-git) - Program to easily change brightness on backlight-controllers.
* [multilockscreen-git](https://aur.archlinux.org/packages/multilockscreen-git) - A simple lock script for i3lock-color
* [polybar](https://aur.archlinux.org/packages/polybar) - A fast and easy-to-use status bar
* [resvg](https://aur.archlinux.org/packages/resvg) - SVG rendering library and CLI
* [rxvt-unicode-patched](https://aur.archlinux.org/packages/rxvt-unicode-patched) - Unicode enabled rxvt-clone terminal emulator (urxvt) with fixed font spacing.
* [spicetify-cli](https://aur.archlinux.org/packages/spicetify-cli) - Command-line tool to customize Spotify client
Read the wiki [Installation spicetify-cli]
* [spotify-dev](https://aur.archlinux.org/packages/spotify-dev) - A proprietary music streaming service 
* [themix-gui-git](https://aur.archlinux.org/packages/themix-gui-git/) - Plugin-based theme designer GUI for environments (like GTK2, GTK3, Cinnamon, GNOME, MATE, Openbox, Xfwm), icons and terminal palettes.
* [themix-full-git](https://aur.archlinux.org/packages/themix-full-git/) - Themix: GUI for generating different color variations of Materia, Oomox themes (GTK2, GTK3, Cinnamon, GNOME, MATE, Openbox, Xfwm), ArchDroid, Gnome-Colors, Numix, Papirus, Suru++ icons, and terminal palettes. Have a hack for HiDPI in GTK2.
* [thunar-extended](https://aur.archlinux.org/packages/thunar-extended) - Thunar with split view, cursor audio preview and extra options for trash, desktop files and user actions
* [yay](https://aur.archlinux.org/packages/yay) - Yet another yogurt. Pacman wrapper and AUR helper written in go.
* [zscroll-git](https://aur.archlinux.org/packages/zscroll-git) - A text scroller for use with panels

### Installation prerequisites
Install oh-my-zsh:

```
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
```
Problems? Refer to [oh-my-zsh GitHub page](https://github.com/ohmyzsh/ohmyzsh)

Install Zinit
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
```
Problems? Refer to [Zinit GitHub page](https://github.com/zdharma/zinit#installation)

### Installation

Run:

```sh
git clone https://github.com/dev-math/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
pacman -S --needed - < misc/pkglist.txt
./.scripts/install.sh
```

### Lightdm
To set lightdm if not already done

```sh
systemctl enable lightdm
```

* edit `/etc/lightdm/lightdm.conf` and set `greeter-session=lightdm-webkit2-greeter` .
* Then edit `/etc/lightdm/lightdm-webkit.conf` and set `theme` or `webkit-theme` to `litarvan` .

---

### Screenshots
#### city.jpg
![city.jpg](https://github.com/dev-math/dotfiles/blob/master/Wallpapers/city.jpg)
