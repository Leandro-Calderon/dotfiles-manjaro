#zmodload zsh/zprof

# Core Settings
export EDITOR='nvim'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export VIMRUNTIME=/usr/share/nvim/runtime
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/home/lean/Public/dotfiles-manjaro/scripts"

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Set name of the theme to load.
ZSH_THEME="agnoster"

# Plugins to load.
plugins=(
    sudo
    zoxide
    zsh-history-substring-search
)

# zoxide
eval "$(zoxide init zsh)"

# Load Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Powerlevel10k theme
source ~/Tools/powerlevel10k/powerlevel10k.zsh-theme

# Instant Prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source oh-my-zsh
#source $ZSH/oh-my-zsh.sh

CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# History Configuration
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS HIST_VERIFY SHARE_HISTORY EXTENDED_HISTORY

# Colores para el resaltado de búsqueda
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=green,bold'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'
export HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# Custom Aliases

# LSD Aliases
alias ls='lsd --group-directories-first'
alias la='lsd -a --group-directories-first'
alias l='lsd -ll --group-directories-first'
alias lt='lsd --tree'
alias lnew='lsd -ltr'
alias ld='lsd -ld */'
alias lmod='lsd -lt'
alias lsize='lsd -lS'
alias ldepth='lsd --tree --depth'

# Git Aliases
alias ad='git add .'
alias cm='git commit -m'
alias ps='git push'
alias st='git status'
alias pl='git pull'
alias gitl='git log --pretty=oneline'
alias gitll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cD) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias gitlp='git log -p'
alias gb='git branch'
alias gc='git checkout'
alias gp='git pull'
alias gf='git fetch'
alias gcm='git checkout main'
alias gcd='git checkout develop'
alias grb='git rebase'
alias gcp='git cherry-pick'
alias grs='git reset --soft'
alias grh='git reset --hard'

# PNPM Aliases
alias pn='pnpm'
alias pnd='pnpm dev'
alias pnb='pnpm build'
alias pnt='pnpm test'
alias pns='pnpm start'

# TypeScript/React Development Aliases
alias tsn='ts-node'
alias tsc='tsc --watch'

# General Aliases
alias de='cd ~/Desktop'
alias dw='cd ~/Downloads'
alias doc='cd ~/Documents'
alias im='cd ~/Pictures'
alias pro='cd ~/Projects'
alias e='exit'
alias v='nvim'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmr='rm -Ir'
alias mkdir='mkdir -pv'

# Script Aliases
alias update="python ~/scripts/update_system.py"
alias monitor="source ~/scripts/scripts/venv/bin/activate && python ~/scripts/monitor_resources.py && deactivate"
alias organize="source ~/scripts/scripts/venv/bin/activate && python ~/scripts/organize_downloads.py && deactivate"
alias syncdotfiles="cd ~/Public/dotfiles-manjaro && git pull && git add . && git diff --cached --quiet || git commit -m \"Sync $(date '+%Y-%m-%d %H:%M:%S')\" && git push && cd -"

# Network Aliases
alias ping='grc ping'
alias traceroute='grc traceroute'
alias netstat='grc netstat'
alias ip='grc ip'
alias ifconfig='grc ifconfig'
alias dig='grc dig'
alias nslookup='grc nslookup'
alias host='grc host'

# Development Aliases
alias gcc='grc gcc'
alias make='grc make'
alias curl='grc curl'
alias wget='grc wget'
alias journalctl='grc journalctl'
alias dmesg='grc dmesg'
alias tail='grc tail'
alias head='grc head'

# pnpm
export PNPM_HOME="/home/lean/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

#the Fuck
eval $(thefuck --alias)

# Functions

# Yazi function
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp" > /dev/null 2>&1  # Suprime el mensaje de eliminación
}

# fzf function

f() {
  fzf --preview '
    case "{}" in
      *.pdf) evince --preview {} ;;
      *.jpg|*.png|*.jpeg|*.gif|*.raw|*.cr2|*.nef) gwenview --preview {} ;;
      *) bat --style=numbers,changes --color=always {} || echo {} ;;
    esac
  ' --bind shift-up:preview-page-up,shift-down:preview-page-down \
    --color=fg:#ffffff,bg:#1e1e1e,hl:#ffcc00,fg+:#000000,bg+:#ffffcc,hl+:#ff9900,info:#00ffff,pointer:#ff0000,marker:#00ff00,spinner:#ff00ff,header:#00ffcc | while read -r file; do
    case "$file" in
      *.md|*.docx|*.odt|*.txt|*.rtf|*.xlsx|*.ods) kate "$file" ;;
      *.pdf) evince "$file" 2>/dev/null ;;
      *.jpg|*.png|*.jpeg|*.gif|*.raw|*.cr2|*.nef) gwenview "$file" 2>/dev/null ;;
      *.epub) foliate "$file" ;;
      *) nvim "$file" ;;
    esac
  done
}

# Load zsh-syntax-highlighting and zsh-autosuggestions
source /home/lean/Tools/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#256182"

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#zprof
