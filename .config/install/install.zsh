# Clone bare repo.
git clone --bare git@github.com:chadbot/dotfiles.git $HOME/.dotfiles

# Move any existing dotfiles files into backup directory.
BACKUP_DIR=$HOME/dotfiles_backup
if [ -d "$BACKUP_DIR" ];
then
    echo "Can't backup dotfiles. $BACKUP_DIR directory already exists." 
    echo "Rename or move this directory and try installing again."
    rm -rf $HOME/.dotfiles
    return
else
    mkdir $BACKUP_DIR
fi

# Copy existing files. Rsync preserves paths.
for file in $(git -C $HOME/.dotfiles ls-tree -r --full-name --name-only HEAD)
do 
    rsync -RW $file $BACKUP_DIR
    rm $file
done

# Define dotfiles alias.
alias dotfiles="git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# Checkout files.
dotfiles checkout

# Set repo to ignore most files...
dotfiles config --local status.showUntrackedFiles no

echo "Dotfiles installed! Restart shell now to finish."
