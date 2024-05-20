shopt -s expand_aliases
# allow for this particular typo
alias cd..='cd ..'

# teleport to system home dir
alias home='cd /mnt/c/Users/kkovacsgamma01/home'

# use mysql easily
alias sql='mysql --user=root --password=password --host=127.0.0.1 --protocol=TCP'

# never show node_modules in tree and always show dirs at the top
alias tree='tree -I node_modules --dirsfirst'

# search without looking into certain folders
alias search='grep -irn --exclude-dir=node_modules/ --exclude-dir=.git/ --exclude=Session.vim --exclude-dir=dist/ --exclude-dir=build/ --exclude-dir=build-touchscreen/ --exclude-dir=coverage/ --exclude=package-lock.json --exclude-dir=generated-docs/ --exclude=.eslintcache --exclude-dir=data/logs/ --exclude=*.svg --exclude=json.hpp --exclude-dir=third-party-libraries --exclude-dir=docker'
alias searchcs='search --no-ignore-case'

# update all packages
alias updateall='sudo sh -c "apt-get update && apt-get upgrade -y && apt-get autoremove --purge -y"'

# always view all branches in gitk and always run in the background
alias gitk='gitk --all &> /dev/null &'

# use gs for git status
alias gs='git status'

# use for copying to the clipboard
clip() {
    "$@" | clip.exe
}

# use lg for lazy git
alias lg='lazygit'

# open a windows explorer window in the current directory
alias exp='explorer.exe .'

# use to connect to raspberry pis over SSH
connect() {
    KEY_SUFFIX=$1
    HOST=$2
    ssh-keygen -f "/home/kkovacs/.ssh/known_hosts" -R "[$2]:22055"
    ssh -i ~/oss-ssh-key-$KEY_SUFFIX -p 22055 -o StrictHostKeyChecking=accept-new oss-gp@$HOST
}

# use bat instead of cat
alias cat='batcat --paging=never'
alias catcat='\cat'
alias catc='catcat'

# easy command for managing config files
alias vimrcgit='/usr/bin/git --git-dir="$HOME/vimrcgit" --work-tree="$HOME"'
alias vgit='vimrcgit'
alias vlg='lazygit --git-dir="$HOME/vimrcgit" --work-tree="$HOME"'
