# dotfiles
These files configure my archlinux environment packages.

### Setup
**OS** [Arch Linux](https://archlinux.org/)
**WM** [i3-gaps](https://github.com/Airblader/i3) (old)
**WM** [AwesomeWM](https://github.com/awesomeWM/awesome/) (current)
**Shell** [Zsh (Z shell)](http://zsh.sourceforge.net/)
**Terminal** [rxvt-unicode](http://software.schmorp.de/pkg/rxvt-unicode.html)
**Terminal font** [Hack](https://github.com/source-foundry/Hack)

### Installation

Run:

```sh
git clone https://github.com/dev-math/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
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
