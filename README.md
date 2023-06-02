# Dotfiles

My basic configuration files. Nothing fancy, but it's convenient.

## Getting started on a new machine

Getting up and running is pretty straightforward.

1. Clone the bare repo to the local machine:

`git clone --bare chadbot/dotfiles $HOME/.dotfiles`

2. Define a `dotfiles` command to easily work with the repo:

`alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"`

3. Checkout the files. Note that this step may fail if files already exist. In that case, just move or rename existing files and retry.

`dotfiles checkout`

4. Configure the local dotfiles repo to ignore untracked files:

`dotfiles config --local status.showUntrackedFiles no`

That's it. Next time you open a ZSH prompt, it should download ZIM and configure everything automatically. 

## Updating or adding files.

Use the `dotfiles` command to add files, commit, and push changes to the repo. For example:

```
dotfiles add .zprofile
dofiles commit -m "Added .zprofile."
dotfiles push
```

Pretty simple. 