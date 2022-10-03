# 日本語関連
export LANG=ja_JP.UTF-8
setopt print_eight_bit

# history関連
HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=10000
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups

# git関連
setopt PROMPT_SUBST
source ~/.zsh/.git-prompt.sh

# プロンプト
PROMPT='%F{cyan}%W%f %F{cyan}%*%f:%F{yellow}%m%f:%F{magenta}%n%f: %F{green}%~%f %F{red}$(__git_ps1 "%s" )%f '

# alias
### alias ###
alias ll='ls -al --color=auto'
alias grep='grep --color'
alias gcm='git cm'
alias gco='git co'
alias gst='git st'
alias gdf='git df'
alias gbr='git br'
alias glo='git gr'
alias gad='git add'
alias pull='git pull'
alias push='git push'
