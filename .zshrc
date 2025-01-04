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

# Copies the current Git SHA to the clip board
# https://stackoverflow.com/a/25899810/4534704
alias gitCopyCurrentSha='git log -1 --format="%H" | pbcopy'
alias gitBranchClean='(git rev-parse --abbrev-ref HEAD | pbcopy) && gsw main && gfa && ggl && git branch -d "$(pbpaste)"'

# takes a commit ref and then get the current branch name and pushes it like `git push origin YOUR_REF:YOUR_BRANCH`
#
alias gitPush='f() { git push origin $1:$(git rev-parse --abbrev-ref HEAD) $2 };f'
