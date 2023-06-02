# Dotfiles

## Usage

First, clone the bare repo to the local machine:

`git clone --bare chadbot/dotfiles $HOME/.dotfiles`

Next, define a `dotfiles` command to easily work with the repo:

`alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"`

Then checkout the files. Note that this step may fail if files already exist. In that case, just move or rename existing files and retry.

`dotfiles checkout`

Finally, configure the local dotfiles repo to ignore untracked files:

`dotfiles config --local status.showUntrackedFiles no`

