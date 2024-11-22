# Enable Powerlevel10k instant prompt
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Core Settings
export EDITOR='nvim'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# History Configuration
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS HIST_VERIFY SHARE_HISTORY EXTENDED_HISTORY

# Oh My Zsh Configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

# Plugins
plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    colored-man-pages
    history
    history-substring-search
    dirhistory
    pj
    pip
    pipenv
    python
    sudo
    node
    nvm
    vim-interaction
)

# Configuración del PATH
export PATH="$HOME/scripts:$PATH"

export PATH="/usr/local/bin:/usr/bin:$HOME/.local/bin:$HOME/.local/share/gem/ruby/3.2.0/bin:$PATH"

# FZF Configuration
export FZF_DEFAULT_OPTS="--color=16 --border --preview 'cat {}'"
export FZF_DEFAULT_COMMAND='fd --type f'

#NVM configuration with lazy loading for faster shell startup
export NVM_DIR="$HOME/.nvm"
# Lazy load nvm
nvm() {
    unset -f nvm
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    nvm "$@"
}

# PNPM Configuration
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Source configurations
source $ZSH/oh-my-zsh.sh
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ColorLS aliases
alias ls='colorls --group-directories-first'
alias la='colorls -a --group-directories-first'
alias l='colorls -l --group-directories-first'
alias ll='colorls -la --group-directories-first'

# LSD aliases
alias lt='lsd --tree'
alias lnew='lsd -ltr'
alias ld='lsd -ld */'
alias lmod='lsd -lt'
alias lsize='lsd -lS'
alias ldepth='lsd --tree --depth'

# Git aliases
alias gitl='git log --pretty=oneline'
alias gitll="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cD) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias gitlp='git log -p'
alias gst='git status'
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
alias e='exit'
alias v='nvim'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias rmr='rm -Ir'
alias mkdir='mkdir -pv'

f() {
  fzf --preview="bat --theme=gruvbox-dark --color=always {} || echo {}" | while read -r file; do
    case "$file" in
      *.md|*.docx|*.odt|*.txt|*.rtf|*.xlsx|*.ods) kate "$file" ;;
      *.pdf) evince "$file" 2>/dev/null ;;
      *.jpg|*.png|*.jpeg|*.gif|*.raw|*.cr2|*.nef) gwenview "$file" 2>/dev/null ;;
      *.epub) foliate "$file" ;;

      *) nvim "$file" ;;
    esac
  done
}

alias update="python ~/scripts/update_system.py"
alias monitor="source ~/scripts/scripts/venv/bin/activate && python ~/scripts/monitor_resources.py && deactivate"
alias organize="source ~/scripts/scripts/venv/bin/activate && python ~/scripts/organize_downloads.py && deactivate"
alias syncdotfiles="cd ~/Public/dotfiles-manjaro && git pull && git add . && git diff --cached --quiet || git commit -m \"Sync $(date '+%Y-%m-%d %H:%M:%S')\" && git push && cd -"

