
dotfiles() {
    if [ -z "$1" ]; then
        /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME
    else
        if [ "$1" = "list" ]; then
            /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME ls-tree --full-tree --name-only -r HEAD
        else
            /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME "$@"
        fi
    fi
}