# Powerlevel10k Configuration
# -------------------------------
source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

# Core Settings
# -------------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR='nvim'
export BROWSER=brave
export VIMRUNTIME=/usr/share/nvim/runtime
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH:/home/lean/Public/dotfiles-manjaro/scripts"

# --------------------------------
# PNPM Configuration
# --------------------------------
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac


# -------------------------------
# Oh-My-Zsh Configuration
# -------------------------------

DISABLE_POWERLEVEL10K_INSTANT_PROMPT=1
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"

plugins=(
  history
  sudo
  zoxide
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-history-substring-search
)

# Source oh-my-zsh (debe ir después de configurar ZSH y el tema)
source $ZSH/oh-my-zsh.sh

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -------------------------------
# History Configuration
# -------------------------------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_REDUCE_BLANKS HIST_VERIFY SHARE_HISTORY EXTENDED_HISTORY

# Colores para el resaltado de búsqueda
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='fg=green,bold'
export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND='fg=red,bold'
export HISTORY_SUBSTRING_SEARCH_GLOBBING_FLAGS='i'

# Cargar alias personalizados
if [ -f ~/.zsh_aliases ]; then
  source ~/.zsh_aliases
fi

# Cargar configuración de funciones
if [ -f ~/.zsh_functions ]; then
  source ~/.zsh_functions
fi

# -------------------------------
# PNPM Configuration
# -------------------------------
export PNPM_HOME="/home/lean/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

SH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#256182"
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# -------------------------------
# NVM Configuration
# -------------------------------
#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
