# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/marcus/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula"

# New Line for commands
# You can display a new line for your commands. So you are able to split the 
# terminal infos and the following command in seperate lines.
DRACULA_DISPLAY_NEW_LINE=1

# NVM Completion
#
# nvm comes with a default bash_completion profile. If you want to
# enable it, you can do it by exporting the NVM_COMPLETION environment
#variable and setting it to true. It must be set before zsh-nvm is loaded.
NVM_COMPLETION=true

# NVM Lazy Loading
#
# If you find nvm adds too much lag to your shell startup you can enable
# lazy loading by exporting the NVM_LAZY_LOAD environment variable and
# setting it to true. It must be set before zsh-nvm is loaded.
#
# Lazy loading is around 70x faster (874ms down to 12ms for me), however
# the first time you run nvm, npm, node or a global module you'll get a
# slight delay while nvm loads first. You'll only get this delay once
# per session.
NVM_LAZY_LOAD=true

# NVM Auto use
#
# If you have lots of projects with an .nvmrc file you may find the auto
# use option helpful. If it's enabled, when you cd into a directory with
# an .nvmrc file, zsh-nvm will automatically load or install the required
# node version in .nvmrc. You can enable it by exporting the NVM_AUTO_USE
# environment variable and setting it to true. It must be set before
# zsh-nvm is loaded.
#
# If you enable this option and don't have nvm loaded in the current
# session (NVM_LAZY_LOAD or NVM_NO_USE) it won't work until you've loaded-
# nvm.
NVM_AUTO_USE=true

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-nvm
    npm
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

## EXPLOSION STUFF
# this is necessary for the caching volumes used in the Dockerfile's
export DOCKER_BUILDKIT=1

alias dcet="docker compose exec -T tools"
export PATH="${HOME}/.pyenv/shims:${PATH}"

# Version Controll Dotfiles Via Git Magic
## 
# Install on new system:
# 1. git clone git@github.com:essenmitsosse/dotfiles.git $HOME/.dotfile.git --bare
#
# 2. /usr/bin/git --git-dir=$HOME/.dotfile.git --work-tree=$HOME checkout
#
# 3. source ~/.zshrc
#    Now `dotfile` should be an alias for running git in the $HOME folder
#
# 4. dotfile config --local status.showUntrackedFiles no
#
# Source: https://www.ackama.com/what-we-think/the-best-way-to-store-your-dotfiles-a-bare-git-repository-explained/
alias dotfile='/usr/bin/git --git-dir=$HOME/.dotfile.git/ --work-tree=$HOME'