if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet


# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"


# Core Settings
export EDITOR='nvim'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History Configuration
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS HIST_VERIFY SHARE_HISTORY EXTENDED_HISTORY


plugins=(
    git
    sudo  
    fzf
    colored-man-pages
    history
    history-substring-search
    dirhistory
    pip
    pipenv
    python
    sudo
    node
    nvm
    vim-interaction
)

source $ZSH/oh-my-zsh.sh

export PATH=$PATH:/usr/bin/google-chrome-stable

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $(dirname $(gem which colorls))/tab_complete.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Funciones

f() {
  fzf --preview="bat --style=numbers,changes --color=always {} || echo {}" \
      --bind shift-up:preview-page-up,shift-down:preview-page-down \
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

# LSD aliases

alias ls='lsd --group-directories-first'
alias la='lsd -a --group-directories-first'
alias l='lsd -la --group-directories-first'
alias lt='lsd --tree'
alias lnew='lsd -ltr'
alias ld='lsd -ld */'
alias lmod='lsd -lt'
alias lsize='lsd -lS'
alias ldepth='lsd --tree --depth'

# Git aliases

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

# PNPM aliases
alias pn='pnpm'
alias pnd='pnpm dev'
alias pnb='pnpm build'
alias pnt='pnpm test'
alias pns='pnpm start'

# TypeScript/React development aliases
alias tsn='ts-node'
alias tsc='tsc --watch'

alias icat="kitten icat"
alias de='cd ~/Desktop'
alias dw='cd ~/Downloads'
alias doc='cd ~/Documents'
alias im='cd ~/Pictures'
alias pro='~/Projects'
alias e='exit'
alias v='nvim'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmr='rm -Ir'
alias mkdir='mkdir -pv'

alias update="python ~/scripts/update_system.py"
alias monitor="source ~/scripts/scripts/venv/bin/activate && python ~/scripts/monitor_resources.py && deactivate"
alias organize="source ~/scripts/scripts/venv/bin/activate && python ~/scripts/organize_downloads.py && deactivate"
alias syncdotfiles="cd ~/Public/dotfiles-manjaro && git pull && git add . && git diff --cached --quiet || git commit -m \"Sync $(date '+%Y-%m-%d %H:%M:%S')
\" && git push && cd -"

alias ping='grc ping'
alias traceroute='grc traceroute'
alias netstat='grc netstat'
alias ip='grc ip'
alias ifconfig='grc ifconfig'
alias dig='grc dig'
alias nslookup='grc nslookup'
alias host='grc host'

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
# pnpm end

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
