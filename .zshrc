# Enable Powerlevel10k prompt (keep at top of .zshrc)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set path
export PATH=$PATH:/opt/homebrew/bin:\
/Applications/Sublime\ Text.app/Contents/SharedSupport/bin:\
/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin:\
/Applications/Julia-1.8.app/Contents/Resources/julia/bin:\
/Applications/Docker.app/Contents/Resources/bin

# Define aliases
source $HOME/.zsh_aliases

# fzf key bindings and completions
source /opt/homebrew/Cellar/fzf/0.42.0/shell/key-bindings.zsh
source /opt/homebrew/Cellar/fzf/0.42.0/shell/completion.zsh

# Run and customize prompt (run `p10k configure` or edit ~/.p10k.zsh to change)
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# iTerm shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# use 256 color
export TERM=xterm-256color

### REMOVE AFTER SURF
### vvvvvvvv

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/homebrew/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/opt/homebrew/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/homebrew/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

### ^^^^^^^^