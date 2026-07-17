# @dev-math dotfiles
These files configure my environment

Table of contents:
- [Workflow](#workflow)
- [Screenshots](#screenshots)
- [Setup](#setup)
- [Container](#container)
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

## Container

`flake.nix` builds a terminal-only container image from these dotfiles
(zsh + zinit + p10k, tmux + tpm, neovim configured from
[dev-math/nvim](https://github.com/dev-math/nvim), ripgrep, fd, fzf, bat,
eza, jq, tealdeer, dust, procs). Requires [Nix](https://nixos.org/download)
with flakes enabled.

```bash
nix build .#dockerImage
docker load -i result   # or: podman load -i result
docker run -it --hostname devcontainer localhost/terminal-devenv:latest
```

Pre-built images publish to `ghcr.io/dev-math/terminal-devenv` on push to
`main` (see `.github/workflows/container-cd.yml`). Test with
`bash tests/container-run.sh` or `nix flake check`.

## Tips

- To generate a theme run ```wal -i path/to/image -o afterwal```
Preferably place the image in the ```~/Pictures/wallpapers``` folder
