# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$HOME/.local/bin:$PATH

# pywal
(cat ~/.cache/wal/sequences &)
# Alternative (blocks terminal for 0-3ms)
# cat ~/.cache/wal/sequences
# To add support for TTYs this line can be optionally added.
# source ~/.cache/wal/colors-tty.sh

# asdf config
. /opt/asdf-vm/asdf.sh

# SPACESHIP_CHAR_SYMBOL="❱"
