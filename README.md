# dotfiles
These files configure my archlinux environment packages.

### AUR Needed
* [gotop] - A terminal based graphical activity monitor inspired by gtop and vtop
* [i3lock-color-git] - An improved screenlocker based upon XCB and PAM with color configuration support
* [polybar] - A fast and easy-to-use status bar
* [rxvt-unicode-pixbuf-patched] - Unicode enabled rxvt-clone terminal emulator (urxvt), with pixbuf, fixed font spacing, fixed line spacing, vi-bindings for matcher and fixed opacity..
* [spotify-dev] - A proprietary music streaming service
* [spicetify-cli] - Command-line tool to customize Spotify client
Read the wiki [Installation spicetify-cli]
* [thunar-extended] - Thunar with split view, cursor audio preview and extra options for trash, desktop files and user actions
* [zscroll-git] - A text scroller for use with panels

### Others
* [zathura-pywal] - A script that dynamically generates a zathura colorscheme based on the current wal colors.
* [oh-my-zsh] - Framework for managing your ZSH configuration.
* [betterdiscord] - Discord extension that introduces new features like BTTV emotes and plugin support.


### Installation

Run:

```sh
git clone https://github.com/dev-math/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
pacman -S --needed - < pkglist.txt
./myscripts/install.sh
```
### Lightdm
To set lightdm if not already done

```sh
systemctl enable lightdm
```

* edit `/etc/lightdm/lightdm.conf` and set `greeter-session=lightdm-webkit2-greeter` .
* Then edit `/etc/lightdm/lightdm-webkit.conf` and set `theme` or `webkit-theme` to `litarvan` .

### Wifi
To connect wifi automatically when logging in run:
```sh
netctl enable <profile-name>
```
Remember to replace the <profile-name> which can be found with ls `/etc/netctl`

---

### Wallpapers
#### city.jpg
![city.jpg](https://github.com/dev-math/dotfiles/blob/master/Wallpapers/city.jpg)
#### nebula.jpg
![nebula.jpg](https://github.com/dev-math/dotfiles/blob/master/Wallpapers/nebula.jpg)
#### onepiece-ace.jpg
![onepiece-ace.jpg](https://github.com/dev-math/dotfiles/blob/master/Wallpapers/onepiece-ace.jpg)
#### purple.jpg
![purple.jpg](https://github.com/dev-math/dotfiles/blob/master/Wallpapers/purple.jpg)
#### redgiant.jpg
![redgiant.jpg](https://github.com/dev-math/dotfiles/blob/master/Wallpapers/redgiant.jpg)
#### serenegreen.jpg
![serenegreen.jpg](https://github.com/dev-math/dotfiles/blob/master/Wallpapers/serenegreen.jpg)
#### spaceingout.jpg
![spacingout.jpg](https://github.com/dev-math/dotfiles/blob/master/Wallpapers/spacingout.jpg)
#### yasuo.jpg
![yasuo.jpg](https://github.com/dev-math/dotfiles/blob/master/Wallpapers/yasuo.jpg)

   [gotop]: <https://aur.archlinux.org/packages/gotop/>
   [i3lock-color-git]: <https://aur.archlinux.org/packages/i3lock-color-git/>
   [polybar]: <https://aur.archlinux.org/packages/polybar/>
   [zathura-pywal]: <https://github.com/GideonWolfe/Zathura-Pywal>
   [oh-my-zsh]: <https://ohmyz.sh/>
   [rxvt-unicode-pixbuf-patched]: <https://aur.archlinux.org/packages/rxvt-unicode-pixbuf-patched/>
   [spotify-dev]: <https://aur.archlinux.org/packages/spotify-dev/>
   [spicetify-cli]: <https://aur.archlinux.org/packages/spicetify-cli/>
   [thunar-extended]: <https://aur.archlinux.org/packages/thunar-extended/>
   [betterdiscord]: <https://gist.github.com/ObserverOfTime/d7e60eb9aa7fe837545c8cb77cf31172>
   [Installation spicetify-cli]: <https://github.com/khanhas/spicetify-cli/wiki/Installation#with-aur>
   [zscroll-git]: <https://aur.archlinux.org/packages/zscroll-git/>
