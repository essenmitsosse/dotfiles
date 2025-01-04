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
alias gitPushOne='f() { git push origin $1:$(git rev-parse --abbrev-ref HEAD) $2 };f'


# The next line updates PATH for Netlify's Git Credential Helper.
test -f '/Users/marcus/Library/Preferences/netlify/helper/path.zsh.inc' && source '/Users/marcus/Library/Preferences/netlify/helper/path.zsh.inc'
# bun completions
[ -s "/Users/marcus/.bun/_bun" ] && source "/Users/marcus/.bun/_bun"

# gitPush:
#   Usage:
#     gitPush [-f] [commitRef] (-n <numCommits> | -s <startRef>) -t <sleepTime>
#
#   Flags/Arguments:
#     -f               (optional) Force only the first push
#     [commitRef]      (optional) Defaults to "HEAD" if not provided
#     -n <numCommits>  (either this or -s)
#                      Example: -n 3 means we'll push from HEAD~3 up to HEAD.
#     -s <startRef>    (either this or -n)
#                      We'll push from the oldest commit in startRef..commitRef
#                      up to the newest (commitRef).
#     -t <seconds>     (required) Sleep time between pushes
#
#   Notes on Order:
#     1) If you use "-n <numCommits>", the first push will be HEAD~<numCommits>
#        and the last push will be HEAD. (Oldest to newest)
#     2) If you use "-s <startRef>", we determine all commits between
#        startRef..commitRef, then push in ascending order (startRef first,
#        commitRef last).
#     3) Only the first push is forced if you pass "-f".
#
#   Examples:
#     1) gitPush -f HEAD -n 3 -t 5
#        => Force-push HEAD~3 first, then HEAD~2, HEAD~1, and finally HEAD.
#
#     2) gitPush -s v1.0.0 -t 2
#        => commitRef defaults to HEAD.
#           If rev-list says v1.0.0..HEAD is [commitA, commitB, commitC, HEAD]
#           oldest to newest, push them in ascending order.
#
#     3) gitPush HEAD -s release-branch -t 3
#        => If "release-branch..HEAD" has N commits in ascending order,
#           push from the oldest among them up to HEAD, 3s apart.
function gitPush() {
  local forceFlag=false
  local commitRef=''
  local t=''
  local n=''
  local startRef=''

 # Parse arguments in any order
  while [[ $# -gt 0 ]]; do
    case "$1" in
      -f)
        forceFlag=true
        shift
        ;;
      -n)
        n="$2"
        shift 2
        ;;
      -s)
        startRef="$2"
        shift 2
        ;;
      -t)
        t="$2"
        shift 2
        ;;
      *)
        # Anything else is treated as the (optional) commitRef
        if [[ -n "$commitRef" ]]; then
          echo "Error: multiple commit references provided: '$commitRef' and '$1'"
          return 1
        fi
        commitRef="$1"
        shift
        ;;
    esac
  done

  # Default commitRef to HEAD if not provided
  [[ -z "$commitRef" ]] && commitRef="HEAD"

  # Validate that the user passed exactly one of -n or -s
  if [[ -n "$n" && -n "$startRef" ]]; then
    echo "Error: Please provide *either* -n <numCommits> or -s <startRef>, not both."
    return 1
  elif [[ -z "$n" && -z "$startRef" ]]; then
    echo "Error: Must provide one of -n <numCommits> or -s <startRef>."
    return 1
  fi

  # Validate that -t (sleep time) was provided
  if [[ -z "$t" ]]; then
    echo "Error: The -t <sleepTime> flag is required."
    return 1
  fi

   # Determine how many pushes we need to do
  local pushes=0

  if [[ -n "$n" ]]; then
    # If -n was provided, we push from 0..n (i.e., n+1 pushes)
    pushes="$n"
  else
    # If -s was provided, calculate totalCommits from startRef..commitRef
    local totalCommits
    totalCommits="$(git rev-list --count "${startRef}..${commitRef}" 2>/dev/null || echo 0)"
    # We'll subtract 1 so if the range has 6 commits, that means we push HEAD down to HEAD~5 (5 steps).
    pushes=$(( totalCommits ))
  fi

  # If there is no difference or it's negative, do nothing
  if (( pushes < 0 )); then
    echo "No commits to push (pushes=$pushes)."
    return 0
  fi

  # We'll build up a single command string joined by &&
  local cmd=''

  # Iterate n down to 0, building the tildes as we go
  for (( i = pushes; i >= 0; i-- )); do
    # Create a string of i tildes: ~~
    local tildes=''
    for (( j = 0; j < i; j++ )); do
      tildes+='~'
    done

    # If cmd is non-empty, append && to chain the commands
    [[ -n "$cmd" ]] && cmd+=" && sleep $t && "

    # If this is the very first push (i == n) and we have -f, add it
    if $forceFlag && [[ $i -eq $pushes ]]; then
      cmd+="git push origin ${commitRef}${tildes}:$(git rev-parse --abbrev-ref HEAD) -f"
    else
      cmd+="git push origin ${commitRef}${tildes}:$(git rev-parse --abbrev-ref HEAD)"
    fi
  done

  YELLOW='\033[0;33m\033[1m'
  BLUE='\033[0;34m'
  NC='\033[0m' # No Color / Reset

  echo "\033[0;34mPushing multiple commits to origin...${NC}"
  if $forceFlag; then
    echo "\033[0;34m- force pushing the first commit${NC}"
  else
    echo "\033[0;34m- no force push${NC}"
  fi
  echo "${BLUE}- pushing${NC} ${YELLOW}$pushes ${BLUE}commits${NC}"
  echo "${BLUE}- waiting for${NC} ${YELLOW}$t ${BLUE}seconds between each${NC}"
  echo "${BLUE}- starting from commit reference:${NC} ${YELLOW}$commitRef${NC}"
  echo "${BLUE}- executing:${NC}"
  echo "${YELLOW}$cmd${NC}"

  # Execute the entire chain in one go
  eval "$cmd"
}
