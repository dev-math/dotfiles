# dotfiles
These files configure my archlinux environment packages.

### AUR Needed
* [gotop] - A terminal based graphical activity monitor inspired by gtop and vtop
* [i3lock-color-git] - An improved screenlocker based upon XCB and PAM with color configuration support
* [polybar] - A fast and easy-to-use status bar

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
