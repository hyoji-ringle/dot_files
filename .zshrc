# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi




# If not running interactively, don't do anything
[[ -o interactive ]] || return

alias pv='ssh -i ~/.ssh/ringle_seoul.pem ec2-user@3.36.218.239'
alias qa='ssh -i ~/.ssh/ringle_seoul.pem ec2-user@3.37.249.66'
alias rs='ssh -i ~/.ssh/ringle_seoul.pem ec2-user@3.35.90.108'


#
# zinit
#
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
source "${ZINIT_HOME}/zinit.zsh"

zplugin ice depth=1
zplugin light romkatv/powerlevel10k

# Show autosuggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1
if is-at-least 5.3; then
zinit ice silent wait'1' atload'_zsh_autosuggest_start'
fi
zinit light zsh-users/zsh-autosuggestions

# Easily access the directories you visit most often.
#
# Usage:
#   $ z work
#   $ <CTRL-G>work
zinit light agkozak/zsh-z
zinit light andrewferrier/fzf-z
export FZFZ_SUBDIR_LIMIT=0

# Automatically expand all aliases
ZSH_EXPAND_ALL_DISABLE=word
zinit light simnalamburt/zsh-expand-all

# Others
zinit light simnalamburt/cgitc
zinit light simnalamburt/ctrlf
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions

autoload -Uz compinit bashcompinit
compinit
bashcompinit
zinit cdreplay

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#
# powerlevel10k. To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
#
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Show me exit codes
typeset -g POWERLEVEL9K_STATUS_ERROR=true
# Less distractive colorscheme
typeset -g POWERLEVEL9K_TIME_FOREGROUND=238
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=242
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=226




#
# zsh-sensible
#
if (( $+commands[lsd] )); then
     alias l='lsd -Al --date=relative --group-dirs=first --blocks=permission,user,size,date,name'
     alias ll='lsd -l --date=relative --group-dirs=first --blocks=permission,user,size,date,name'
     alias lt='lsd --tree --depth=2 --date=relative --group-dirs=first'
else
    alias l='ls -alh --color=auto'
    alias ll='ls -lh --color=auto'
fi

alias mv='mv -i'
alias cp='cp -i'

HISTSIZE=90000
SAVEHIST=90000
HISTFILE=~/.zsh_history

setopt auto_cd histignorealldups sharehistory
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
# Substring completion
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Clear screen
clear_screen() { tput clear }
zle -N clear_screen
bindkey '^s' clear_screen


#
# lscolors
#
export LS_COLORS="di=1;33:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=30;46:tw=0;42:ow=30;43"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
export LSCOLORS="Gxfxcxdxbxegedxbagxcad"
export TIME_STYLE='long-iso'
autoload -U colors && colors


#
# zsh-substring-completion
#
setopt complete_in_word
setopt always_to_end
WORDCHARS=''
zmodload -i zsh/complist



### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk
#
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
