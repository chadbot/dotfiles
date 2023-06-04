# Dotfiles

My basic configuration files. Nothing fancy, but it's convenient.

## Getting started on a new machine

### The super simple way

The simplest way to get running quickly is to open a zsh shell and run the following command:

```
source <(curl -s https://raw.githubusercontent.com/chadbot/dotfiles/main/.config/install/install.zsh)
```

This will clone the dotfiles repo, backup any existing dotfiles, then checkout all dotfiles to their appropriate locations.

### The slightly more manual way

The step-by-step method is also pretty straightforward:

1. Clone the bare repo to the local machine:

```bash
git clone --bare chadbot/dotfiles $HOME/.dotfiles
```

2. Define a `dotfiles` command to easily work with the repo:

```bash
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
````

1. Checkout the files. Note that this step may fail if files already exist. In that case, just move or rename existing files and retry.

```bash
dotfiles checkout
````

4. Configure the local dotfiles repo to ignore untracked files:

```bash
dotfiles config --local status.showUntrackedFiles no
```

That's it. Next time you open a ZSH prompt, it should download ZIM and configure everything automatically.

## Updating or adding files

Use the `dotfiles` command to add files, commit, and push changes to the repo. For example:

```bash
dotfiles add .zprofile
dofiles commit -m "Added .zprofile."
dotfiles push
```

Pretty simple, really.
