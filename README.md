# @dev-math dotfiles
These files configure my environment

Table of contents:
- [Workflow](#workflow)
- [Screenshots](#screenshots)
- [Setup](#setup)
- [Tips](#tips)
- [Credits](#credits)

## Workflow

<img src="https://i.imgur.com/K9PBtBv.png" alt="img" align="right" width="400px">

- **WM:** sway
- **Shell:** [Zsh (Z shell)](http://zsh.sourceforge.net/) with [powerlevel10k](https://github.com/romkatv/powerlevel10k) framework
- **Terminal:** [Alacritty](https://github.com/alacritty/alacritty)
- **Editor**: [Neovim](https://github.com/neovim/neovim/)
- **Terminal font:** Meslo
- **Launcher**: [rofi](https://github.com/davatorium/rofi/)
- **Browser**: [Librewolf](https://librewolf.net)

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

## Setup 
```bash
chezmoi init https://github.com/dev-math/dotfiles
chezmoi update
```

## Tips

- To generate a theme run ```wal -i path/to/image -o afterwal```
Preferably place the image in the ```~/Pictures/wallpapers``` folder
