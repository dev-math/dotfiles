source $ZDOTDIR/sshagent

# - - - - - - - - - - - - - - - - - - - -
# Enable Instant Prompt
# - - - - - - - - - - - - - - - - - - - -
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# - - - - - - - - - - - - - - - - - - - -
# User Config
# - - - - - - - - - - - - - - - - - - - -
setopt autocd # change directory without 'cd'

source $ZDOTDIR/pywal
source $ZDOTDIR/aliases
source $ZDOTDIR/completion.zsh
source $ZDOTDIR/history.zsh
source $ZDOTDIR/key-bindings.zsh
source $ZDOTDIR/zinit.zsh # Load zsh addons (zinit plugins, autocomplete, Powerlevel10k, etc.)
[[ ! -f $ZDOTDIR/p10k ]] || source $ZDOTDIR/p10k # p10k config
source $HOME/.asdf/asdf.sh
[[ ! -f ~/.asdf/plugins/java/set-java-home ]] || source ~/.asdf/plugins/java/set-java-home.zsh

# - - - - - - - - - - - - - - - - - - - -
# End
# - - - - - - - - - - - - - - - - - - - -
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
_comp_options+=(globdots)		# Include hidden files.
