# Personal zshrc file

# NOTE: ZSH extensions (including PowerLevel10k prompt) managed through Zim. 
# To update zim: zimfw upgrade
# To update zim modules: zimfw update


# ---- POWERLEVEL10K ----

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# If p10k not already installed, zim will install in next section.

# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# ---- ZIM ZSH Addon Management ----

# define zim locaiton
ZIM_HOME=$HOME/.zim

# zim modules
zstyle ':zim:zmodule' use 'degit'

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

# ---- CONDA ----

# NOTE: modified conda-generated code to use $HOME instead of static paths

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('${HOME}/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "${HOME}/miniconda/etc/profile.d/conda.sh" ]; then
        . "${HOME}/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="${HOME}/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# ---- COMPLETIONS ----

# add custom completions to fpath (must come before ZIM modules)
fpath=($HOME/.config/zsh/completions $fpath)

# add homebrew completions, if homebrew installed
if command -v brew &> /dev/null; then
    fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fi

# add 1password cli completions, if 1password cli installed
if command -v op &> /dev/null; then
    op completion zsh > $HOME/.config/zsh/completions/_op
fi

# run compinit 
autoload -Uz compinit
compinit  # -uf

# ---- ALIASES AND FUNCTIONS ----

source $HOME/.config/zsh/aliases.zsh
source $HOME/.config/zsh/functions.zsh

# ---- POWERLINE10K ----

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/.p10k.zsh ]] || source $HOME/.p10k.zsh
