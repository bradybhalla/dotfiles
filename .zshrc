##########
# Prompt #
##########

# Enable Powerlevel10k prompt (keep at top of .zshrc)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Run and customize prompt (run `p10k configure` or edit ~/.p10k.zsh to change)
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh


########################
# Path, aliases, shell #
########################

# Set path
export PATH=$PATH:/opt/homebrew/bin:\
/Applications/Sublime\ Text.app/Contents/SharedSupport/bin:\
/Applications/Sublime\ Merge.app/Contents/SharedSupport/bin:\
/Applications/Julia-1.8.app/Contents/Resources/julia/bin:\
/Applications/Docker.app/Contents/Resources/bin:\
$HOME/.ghcup/bin

# Define aliases and functions
[[ -r "$HOME/.zsh_aliases" ]] && source "$HOME/.zsh_aliases"

# fzf key bindings and completions
eval "$(fzf --zsh)"

# iTerm2 shell integration
test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"

# zsh-autosuggestions
[[ -r "$HOME/bin/zsh-autosuggestions/zsh-autosuggestions.zsh" ]] && source "$HOME/bin/zsh-autosuggestions/zsh-autosuggestions.zsh"

# zsh-syntax-highlighting (keep at bottom of .zshrc)
[[ -r "$HOME/bin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]] && source "$HOME/bin/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"


###############
# Programming #
###############

# Python configuration
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

# OCaml configuration
[[ -r "$HOME/.opam/opam-init/init.zsh" ]] && source "$HOME/.opam/opam-init/init.zsh"  > /dev/null 2> /dev/null

# Ruby configuration
[[ -r "/opt/homebrew/opt/chruby/share/chruby/chruby.sh" ]] && source "/opt/homebrew/opt/chruby/share/chruby/chruby.sh"
[[ -r "/opt/homebrew/opt/chruby/share/chruby/auto.sh" ]] && source "/opt/homebrew/opt/chruby/share/chruby/auto.sh"
